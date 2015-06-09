require 'spec_helper'

describe DssParser do
  describe '#initialize' do
    it 'returns an error if the directory provided does not exist' do
      expect { DssParser.new('/tmp/zzz') }.to raise_error DssParser::NotFound
    end

    it 'returns an error if the parameter provided is not a directory' do
      expect {
        DssParser.new(File.expand_path('./spec/fixtures/not_a_directory'))
      }.to raise_error DssParser::NotADirectory
    end
  end

  describe '#get_comments' do
    it 'finds comments in css files' do
      parser = DssParser.new(File.expand_path('./spec/fixtures/standard'))
      comments = parser.get_dss

      expect(comments.size).to eq 4
    end

    it 'finds dss attributes in dss comments' do
      parser = DssParser.new(File.expand_path('./spec/fixtures/standard'))
      comments = parser.get_dss

      mixin = comments[0]
      dss_button = comments[1]

      expect(dss_button.name).to eq "Button"
      expect(dss_button.description).to eq "Style for a button\nthis is a multiline description"
      expect(dss_button.states.size).to eq 3
      expect(dss_button.states.first.name).to eq ":disabled"
      expect(dss_button.states.first.description).to eq "Dims the button when disabled."
      expect(dss_button.markup).to eq "<button>markup</button>"
      expect(dss_button.section).to eq "Forms.Buttons"

      expect(mixin.variables.size).to eq 2
      expect(mixin.variables.first.name).to eq "$Start"
      expect(mixin.variables.first.description).to eq "A hex color at the top of the gradient"

    end

    it 'allows dashes in class names' do
      parser = DssParser.new(File.expand_path('./spec/fixtures/standard'))
      comments = parser.get_dss

      dss_button = comments[3]

      dashed_state = dss_button.states.last

      expect(dashed_state.name).to eq ".even-smaller"
      expect(dashed_state.description).to eq "even smaller button"
    end
  end

  it 'finds DSS comments within nested folders' do
    parser = DssParser.new(File.expand_path('./spec/fixtures/nested'))
    comments = parser.get_dss

    expect(comments.size).to eq 3
  end
end
