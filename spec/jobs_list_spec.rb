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
    subject(:jobs_list) {  }

    context 'Valid data' do

      it 'returns jobs in any order with no dependency' do
        result = JobsList.new('inputs/with_no_dependency').sorted_jobs
        ['a', 'b', 'c'].each do |job|
          expect(result).to include(job)
        end
      end

      it 'returns jobs in topogical order by given dependecies' do
        result = JobsList.new('inputs/with_dependencies').sorted_jobs

        {'b' => 'c', 'c' => 'f', 'd' => 'a', 'e' => 'b'}.each_pair do |job, dependency|
          expect(result.index(dependency)).to be < result.index(job)
        end
      end
    end

    context 'Invalid data' do

      it 'returns error for circular dependency' do
        result = JobsList.new('inputs/with_circular_dependency').sorted_jobs
        expect(result).to eq(JobsList::CIRCULAR_DEPENDENCY_ERROR)
      end

      it 'returns error for self dependency' do
        result = JobsList.new('inputs/with_self_dependency').sorted_jobs
        expect(result).to eq(JobsList::SELF_DEPENDENCY_ERROR)
      end
    end

  end


end
