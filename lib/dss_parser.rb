require "dss_parser/version"
require "dss_parser/parsers/name"
require "dss_parser/parsers/description"
require "dss_parser/parsers/states"
require "dss_parser/parsers/markup"
require "dss_parser/parsers/section"
require "dss_parser/parsers/variables"

class DssParser
  def initialize(stylesheet_path)
    @stylesheet_path = stylesheet_path
    @parsers = [DssParser::Parser::Name,
                DssParser::Parser::Description,
                DssParser::Parser::States,
                DssParser::Parser::Markup,
                DssParser::Parser::Variables,
                DssParser::Parser::Section]
  end

  def find_css_files
    Dir.glob("#{@stylesheet_path}**/*.css*")
  end

  def get_comments
    comments = []
    dss = []

    find_css_files.each do |file_path|
      css_file = IO.read(file_path)
      comments |= parse_for_comments(css_file)
    end

    comments.each do |c|
      dss.push build_dss(c)
    end

    dss
  end

  def parse_for_comments(css)
    comment_blocks = []
    in_comment = false
    current_comment = []
    lines = css.split "\n"

    lines.each do |line_of_css|
      line_of_css.strip!

      if commented_css_line?(line_of_css, in_comment)
        in_comment = true
        current_comment.push "#{line_of_css}"
        if line_of_css.end_with?('*/')
          in_comment = false
        end
      else
        in_comment = false
        comment_blocks.push current_comment if is_dss_comment?(current_comment)
        current_comment = []
      end
    end

    lines.each do |line_of_css|
      line_of_css.strip!

      if commented_sass_line?(line_of_css, in_comment)
        in_comment = true

        current_comment.push "#{line_of_css}"
        unless line_of_css.start_with?('//')
          in_comment = false
        end
      else
        in_comment = false
        comment_blocks.push current_comment if is_dss_comment?(current_comment)
        current_comment = []
      end
    end
    strip_whitespace(comment_blocks)
  end

  def build_dss(comment)
    dss = []
    @parsers.each do |parser|
      parsed_content = parser.parse(comment)
      puts parsed_content
      dss.push parsed_content unless parsed_content.nil?
    end
    dss.reduce({}, :merge)
  end

  private

  def register_parser(parser)
    @parsers.push parser
  end

  def is_dss_comment?(comment)
    comment.any? { |line| line.downcase.include?("@name") || line.downcase.include?("@mixin") }
  end

  def commented_css_line?(line, in_comment)
    if css_comment?(line) || in_comment == true
      in_comment = true
      return true
    end
  end

  def commented_sass_line?(line, in_comment)
    if scss_comment?(line) || in_comment == true
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

  def strip_whitespace(comment_blocks)
    comment_blocks.each do |comment|
      comment.map!{ |c| c.gsub(/^\/\//, '') }
      comment.map!{ |c| c.gsub(/^\/\*/, '') }
      comment.map!{ |c| c.gsub(/^\*\//, '') }
      comment.map!{ |c| c.gsub(/^\*/, '') }
      comment.map!{ |c| c.strip }
      comment.reject!{ |c| c.size < 1 }
    end

    comment_blocks.reject{ |c| c.size < 1 }
  end
end
