class InputParser

  SEPARATOR = '=>'.freeze

  EMPTY_INPUT_ERROR = 'empty input'.freeze
  INVALID_FORMAT = "please add only 1 #{SEPARATOR} in 1 input line".freeze

  attr_reader :job, :dependency

  def initialize(raw_input)
    @raw_input = raw_input.to_s.strip
    raise EMPTY_INPUT_ERROR if @raw_input.empty?
  end

  def parse
    inputs = @raw_input.split(SEPARATOR)

    raise INVALID_FORMAT if inputs.length > 2

    @job = inputs.first.strip
    @dependency = inputs.last.strip if (inputs.length > 1 and not inputs.last.strip.empty?)

    self
  end


end
