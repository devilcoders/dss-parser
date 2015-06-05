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

      if commented_line?(line_of_css, in_comment)
        in_comment = true
        current_comment.push "#{line_of_css}"
        if line_of_css.size == 0 || line_of_css.end_with?('*/')
          in_comment = false
        end
      else
        in_comment = false
        comment_blocks.push current_comment if is_dss_comment?(current_comment)
        current_comment = []
      end
    end

    comment_blocks
  end

  private

  def is_dss_comment?(comment)
    comment.any? { |line| line.downcase.include?("@name") || line.downcase.include?("@mixin") }
  end

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
