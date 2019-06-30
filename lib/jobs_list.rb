require_relative 'utils/input_parser'

class JobsList

  #  =============
  #  = Constants =
  #  =============
  INVALID_FILE_ERROR = 'please provide correct input file'.freeze
  SELF_DEPENDENCY_ERROR = 'jobs can\'t depend on themselves'.freeze
  CIRCULAR_DEPENDENCY_ERROR = 'jobs can\'t have circular dependencies'.freeze

  #  ===================
  #  = Setters/Getters =
  #  ===================
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

  #  ===================
  #  = Private methods =
  #  ===================
  private

    def parse_input_and_build_dependencies
      File.open(file_path).each do |line|
        parsed_input = InputParser.new(line.chomp).parse
        self.error = SELF_DEPENDENCY_ERROR and return if (parsed_input.job == parsed_input.dependency)
        dependencies[parsed_input.job] = parsed_input.dependency
      end
    end

    # Applying the algorithm which takes care of job dependecies and circular depedency as well.
    # We have 2 references (hash) for jobs i.e. "visited" and "in_call_stack"
    # "visited" is take care of already visited or processed jobs so that we dont
    #   process the same job again
    # "in_call_stack" will help us in finding circular dependency. If a job is already in
    #   inside the call stack (since our "helper" function is recursive) that means
    #   we have a circular dependency and we'll break the recursion with setting the "error"
    def sort_by_dependencies
      visited = Hash[dependencies.keys.map {|k| [k, false]}]
      in_call_stack = {}
      dependencies.each_pair do |job, dependency|
        return if error
        helper(visited, in_call_stack, job) unless visited[job]
      end
      result
    end

    def helper(visited, in_call_stack, job)
      self.error = CIRCULAR_DEPENDENCY_ERROR and return if in_call_stack[job]
      return if visited[job]

      if dependencies[job]
        in_call_stack[job] = true
        helper(visited, in_call_stack, dependencies[job])
      end

      in_call_stack[job] = false
      visited[job] = true
      result << job
    end



end
