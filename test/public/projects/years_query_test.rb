# frozen_string_literal: true

module Projects
  class YearsQueryTest < ActiveSupport::TestCase
    test '.preform returns an array of all years in the database' do
      years = [1234, 5678, 91_011]

      years.each { |year| create(:project, year: year) }

      result = Projects::YearsQuery.new.perform

      assert_not_nil result
      assert_equal years, result
    end

    test '.perform returns empty array if there are no projects in database' do
      result = Projects::YearsQuery.new.perform

      assert result.empty?
    end
  end
end
