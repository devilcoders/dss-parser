require "dss_parser/version"

class DssParser
  def initialize(stylesheet_path)
    @stylesheet_path = stylesheet_path
  end

  def find_css_files
    Dir.glob("#{@stylesheet_path}**/*.css*")
  end

  def get_comments
    comments = []

    find_css_files.each do |file_path|
      css_file = IO.read(file_path)
      comments |= parse_for_comments(css_file)
    end

    comments
  end

  def parse_for_comments(css)
    comment_blocks = []
    in_comment=false
    current_comment = []
    lines = css.split "\n"

    lines.each do |line_of_css|
      line_of_css.strip!

      puts ""
      puts line_of_css

      if commented_line?(line_of_css, in_comment)
        puts "true"
        in_comment = true
        current_comment.push "#{line_of_css}"
        puts line_of_css.size
        if line_of_css.size == 0 || line_of_css.end_with?('*/')
          in_comment = false
          puts 'end of comments'
        end
      else
        puts "false"
        in_comment = false
        comment_blocks.push current_comment if current_comment.size > 0
        current_comment = []
      end
    end

    puts comment_blocks.inspect

  comment_blocks
    # Remove comments which do not fit DSS syntax
    #comment_blocks.select { |comment| comment.any? { |s| s.downcase.include? "@name" } }
  end

  private

  def commented_line?(line, in_comment)
    if css_comment?(line) || scss_comment?(line) || in_comment == true
      in_comment = true
      return true
    end
  end

  def css_comment?(line)
    line.start_with?('/*','*/') && !line.end_with?('*/')
  end

  def scss_comment?(line)
    line.start_with? '//'
  end
end
