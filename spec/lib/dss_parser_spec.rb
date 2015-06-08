require 'spec_helper'

describe DssParser do
  describe '#get_comments' do
    it 'finds comments in css files' do
      parser = DssParser.new("#{File.expand_path('../..', __FILE__)}/fixtures/")
      comments = parser.get_dss

      expect(comments.size).to eq 4
    end

    it 'finds dss attributes in dss comments' do
      parser = DssParser.new("#{File.expand_path('../..', __FILE__)}/fixtures/")
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
  end
end
