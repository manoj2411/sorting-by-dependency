require_relative 'utils/input_parser'

class JobsList

  INVALID_FILE_ERROR = 'please provide correct input file'.freeze
  SELF_DEPENDENCY_ERROR = 'jobs can\'t depend on themselves'.freeze
  CIRCULAR_DEPENDENCY_ERROR = 'jobs can\'t have circular dependencies'.freeze

  attr_reader :file_path
  attr_accessor :error, :dependencies, :result

  def initialize(file_path)
    raise INVALID_FILE_ERROR if file_path.nil? || !File.exists?(file_path)
    @file_path = file_path
    @dependencies = {}
    @error = false
    @result = []
  end

  def sorted_jobs
    parse_input_and_build_dependencies
    sort_by_dependencies
    error || result
  end

  private
    def parse_input_and_build_dependencies
      File.open(file_path).each do |line|
        parsed_input = InputParser.new(line.chomp).parse
        self.error = SELF_DEPENDENCY_ERROR and return if (parsed_input.job == parsed_input.dependency)
        dependencies[parsed_input.job] = parsed_input.dependency
      end
    end

    def sort_by_dependencies
      visited = Hash[dependencies.keys.map {|k| [k, false]}]
      in_stack = {}
      dependencies.each_pair do |job, dependency|
        return if error
        helper(visited, in_stack, job) unless visited[job]
      end
      result
    end

    def helper(visited, in_stack, job)
      self.error = CIRCULAR_DEPENDENCY_ERROR and return if in_stack[job]
      return if visited[job]

      if dependencies[job]
        in_stack[job] = true
        helper(visited, in_stack, dependencies[job])
      end

      in_stack[job] = false
      visited[job] = true
      result << job
    end



end
