class JobsList
  INVALID_FILE_ERROR = "please provide correct input file".freeze

  def initialize(file_path)
    raise INVALID_FILE_ERROR if file_path.nil? || !File.exists?(file_path)

    @file_path = file_path
  end

  def sorted_jobs
    'result'
  end


end
