require 'spec_helper'

describe DssParser do
  describe '#find_css_files' do
    it 'finds all css/scss files in the folder  passed into the parser' do
      parser = DssParser.new("#{File.expand_path('../..', __FILE__)}/fixtures/")
      css_files = parser.find_css_files

      expect(css_files).to be_instance_of Array
      expect(css_files.size).to eq 2 
    end
  end

  describe '#get_comments' do
    it 'finds comments in css files' do
      parser = DssParser.new("#{File.expand_path('../..', __FILE__)}/fixtures/")
      comments = parser.get_comments

      expect(comments.size).to eq 1
    end
  end
end
