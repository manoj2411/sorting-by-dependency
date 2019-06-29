require './lib/utils/input_parser'

RSpec.describe InputParser do

  let(:parsed_input) { InputParser.new("a => b").parse }

  describe '.parse' do
    context "valid input" do
      it "should return InputParser object" do
        expect(parsed_input).to be_a_kind_of(InputParser)
      end

      it "should parse input and return job" do
        expect(parsed_input.job).to eq('a')
      end

      it "should parse input and return job's dependency if present" do
        expect(parsed_input.dependency).to eq('b')
      end

      it "should parse input and return job's dependency as nil if not present" do
        input_without_space = InputParser.new("a =>").parse
        input_with_space = InputParser.new("a => ").parse
        expect(input_without_space.dependency).to be_nil
        expect(input_with_space.dependency).to be_nil
      end

    end

    context "invalid input" do
      it 'should not raise_error non string values' do
        [nil, "", " "].each do |input|
          expect { InputParser.new(input).parse }.to raise_error(InputParser::EMPTY_INPUT_ERROR)
        end
      end

      it 'should not raise_error non string values' do
        expect { InputParser.new("a => b => c").parse }.to raise_error(InputParser::INVALID_FORMAT)
      end
    end
  end


end
