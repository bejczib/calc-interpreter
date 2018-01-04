require 'spec_helper'

describe Lexer do
  subject { Lexer.new(text).advance! }

  context 'when the text contains invalid char' do
    let(:text) { '^'}

    it "should log the invalid char" do
      expect{ subject }.to raise_error RuntimeError, 'Invalid type for ^'
    end
  end

  context 'when the text contains only valid chars' do
    let(:text) { '2'}

    it "should give back the token" do
      expect(Token).to receive(:new).with(:integer, '2')
      subject
    end
  end
end
