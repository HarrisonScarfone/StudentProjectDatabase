module Projects
  class YearsQuery
    def perform
      Project.distinct.pluck(:year)
    end
  end
end
  
  
      