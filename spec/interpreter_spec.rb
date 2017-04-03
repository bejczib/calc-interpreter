require 'spec_helper'

describe Interpreter do

[
  {expression: "1+1",expected: 2},
  {expression: "1-1",expected: 0},
  {expression: "12+1",expected: 13},
  {expression: "4+16",expected: 20}
].each do |test_case|
    context "when the the expression to eval is #{test_case[:expression]}" do

      let(:instance) { described_class.new(test_case[:expression])}

      subject { instance.evaluate }

      it { is_expected.to eq test_case[:expected] }
    end
  end
end