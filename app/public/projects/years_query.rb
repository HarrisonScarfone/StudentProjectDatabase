# frozen_string_literal: true

module Projects
  class YearsQuery
    def perform
      Project.distinct.pluck(:year)
    end
  end
end
