module Projects
  class ProjectsController < ApplicationController
    before_action :validate_params, :populate_navbar_items

    def index
      @project = random_project
      render template: 'projects/index'
    end

    def projects
      @projects = projects_to_be_displayed
      render template: 'projects/projects'
    end

    private

    def populate_navbar_items
      @populate_navbar__items ||= begin
        @departments = Projects::DepartmentsQuery.new().perform()
        @years = Projects::YearsQuery.new().perform()
      end
    end

    def random_project
      Projects::RandomProjectQuery.new().perform()
    end

    def validate_params
      validated_params = {
        page: 1,
        department: nil,
        year: nil,
        name: nil,
      }

      if params['page']&.to_i
        validated_params[:page] = params['page']
      end

      if params['department'].present? && Project.departments.keys.include?(params['department'].downcase)
        if params['year'].present? && params['year']&.to_i
          validated_params[:department] = params['department'].downcase
          validated_params[:year] = params['year']
        end
      elsif params['name'].present?
        # TODO: regex validate params?
        validated_params[:name] = params['name']
      else   
        false
      end

      @validated_params = validated_params
    end

    def projects_to_be_displayed
      Projects::ProjectsQuery.new(
        page: @validated_params[:page],
        year: @validated_params[:year],
        department: @validated_params[:department],
        name: @validated_params[:name]
      ).perform()
    end
  end
end
