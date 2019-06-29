require 'spec_helper'
require 'jobs_list'


RSpec.describe JobsList do

  describe '#sorted_jobs' do
    subject(:jobs_list) { JobsList.new }

    context 'Valid data' do

      it 'returns jobs in any order with no dependency' do
      end

      it 'returns jobs in topogical order by given dependecies' do
      end
    end

    context 'Invalid data' do

      it 'returns error for circular dependency' do
      end

      it 'returns error for self dependency' do
      end
    end

  end


end
