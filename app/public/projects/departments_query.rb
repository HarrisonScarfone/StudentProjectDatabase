# frozen_string_literal: true

module Projects
  class DepartmentsQuery
    def perform
      Project.departments.keys.map(&:titleize)
    end
  end
end
