# frozen_string_literal: true

module Projects
  class DepartmentQueryTest < ActiveSupport::TestCase
    test '.preform returns departments as a array of titlelized enum keys' do
      departments = %w[Electrical Mechanical Civil Environmental Industrial]

      result = Projects::DepartmentsQuery.new.perform

      assert_not_nil result
      assert_equal departments, result
    end
  end
end
