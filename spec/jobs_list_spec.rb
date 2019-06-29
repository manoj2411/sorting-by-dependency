require 'spec_helper'
require 'jobs_list'


RSpec.describe JobsList do

  context 'invalid input file' do
    ["", "inputs/file1", "file1", nil].each do |file|
      it "\"#{file}\" should return invalid file error" do
        expect { JobsList.new(file) }.to raise_error(JobsList::INVALID_FILE_ERROR)
      end
    end
  end

  describe '#sorted_jobs' do
    subject(:jobs_list) { JobsList.new 'inputs/with_single_job' }

    context 'Valid data' do

      xit 'returns jobs in any order with no dependency' do
      end

      xit 'returns jobs in topogical order by given dependecies' do
      end
    end

    context 'Invalid data' do

      xit 'returns error for circular dependency' do
      end

      xit 'returns error for self dependency' do
      end
    end

  end


end
