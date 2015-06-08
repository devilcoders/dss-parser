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

      expect(comments.size).to eq 4
    end

    it 'finds dss attributes in dss comments' do
      parser = DssParser.new("#{File.expand_path('../..', __FILE__)}/fixtures/")
      comments = parser.get_comments

      puts comments

      expect(comments[1][:name]).to eq "Button"
      expect(comments[1][:description]).to eq "Style for a button\nthis is a multiline description"
      expect(comments[1][:states].size).to eq 3
      expect(comments[1][:states].first[:name]).to eq ":disabled"
      expect(comments[1][:states].first[:description]).to eq "Dims the button when disabled."
      expect(comments[0][:variables].size).to eq 2
      expect(comments[0][:variables].first[:name]).to eq "$Start"
      expect(comments[0][:variables].first[:description]).to eq "A hex color at the top of the gradient"
      expect(comments[1][:markup]).to eq "<button>markup</button>"
      expect(comments[1][:section]).to eq "Forms.Buttons"
    end
  end
end
