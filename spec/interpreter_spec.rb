require 'spec_helper'

describe Interpreter do
  [
    {text: '1+1',result: 2},
    {text: '1-1',result: 0},
    {text: '1*1',result: 1},
    {text: '1/1',result: 1},
    {text: '-123',result: -123},
    {text: '123',result: 123},
    {text: '2/2+3*4.75--6',result: 21.25},
    {text: '12*123',result: 1476},
    {text: '2/(2+3)*4.33--6',result: 7.732},
    {text: '12*123/-(-5+2)',result: 492},
    {text: '((2.33/(2.9+3.5)*4)--6)',result: 7.45625},
  ].each do |test_case|
    context "when the text is #{test_case[:text]}" do
      let(:lexer) { Lexer.new(test_case[:text]) }
      let(:parser) { Parser.new(lexer) }

      it "should do the math" do
        expect(described_class.new(parser).call).to eq test_case[:result]
      end
    end
  end
end
