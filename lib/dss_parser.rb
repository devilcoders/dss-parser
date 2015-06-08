PARSER_PATH = "#{File.expand_path('../..', __FILE__)}/lib/dss_parser/parsers/*.rb"

require 'ostruct'
require "dss_parser/version"
Dir[PARSER_PATH].each {|file| require file }

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

  def get_dss
    comments = []

    find_css_files.each do |file_path|
      css_file = IO.read(file_path)
      comments |= parse_for_comments(css_file)
    end

    comments.map! { |c| build_dss(c) }
  end

  def register_parser(parser)
    @parsers.push parser
  end

  private

  def parse_for_comments(css)
    lines = css.split "\n"

    css_comments = find_css_comments(lines)
    sass_comments = find_sass_comments(lines)

    strip_whitespace(css_comments | sass_comments)
  end

  def build_dss(comment)
    dss = []
    @parsers.each do |parser|
      parsed_content = parser.parse(comment)
      dss.push parsed_content unless parsed_content.nil?
    end
    OpenStruct.new(dss.reduce({}, :merge))
  end

  def find_css_files
    Dir.glob("#{@stylesheet_path}**/*.css*")
  end

  def find_sass_comments(lines)
    in_comment = false
    current_comment = []
    comment_blocks = []

    lines.each do |line_of_css|
      line_of_css.strip!

      if scss_comment?(line_of_css) || in_comment == true
        in_comment = true

        current_comment.push line_of_css
        unless line_of_css.start_with?('//')
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

  def find_css_comments(lines)
    in_comment = false
    current_comment = []
    comment_blocks = []

    lines.each do |line_of_css|
      line_of_css.strip!

      if css_comment?(line_of_css) || in_comment == true
        in_comment = true
        current_comment.push line_of_css
        if line_of_css.end_with?('*/')
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

  def is_dss_comment?(comment)
    comment.any? { |line| line.downcase.include?("@name") || line.downcase.include?("@mixin") }
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
