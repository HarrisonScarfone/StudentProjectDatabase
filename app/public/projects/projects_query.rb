module Projects
  class ProjectsQuery
    def initialize(page:, department:, year:, name:)
      @page = page
      @department = department
      @year = year
      @name = name
    end

    def perform
      if @department.present? && @year.present?
        projects = Project.page(@page).per(3)
        projects.where(department: @department, year: @year)
      elsif @name.present?
        Project.left_joins(:people)
        .where("LOWER(people.name)= ?", @name.downcase)
        .or(Project.left_joins(:people)
        .where("LOWER(title)= ?", @name.downcase))
        .distinct
        .page(@page)
        .per(3)
     end
    end
  end
end


    