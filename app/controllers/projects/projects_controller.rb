module Projects
  class ProjectsController < ApplicationController
    before_action :validate_params

    def index
      @project = random_project
      render template: 'projects/index'
    end

    def projects
      @projects = projects_to_be_displayed
      render template: 'projects/projects'
    end

    private

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
          @validated_params = validated_params
        end
      elsif
        # TODO: regex validate params?
        params['name'].present?
          validated_params[:name] = params['name']
          @validated_params = validated_params
      end

      false
    end

    def projects_to_be_displayed
      query = Projects::ProjectQuery.new(
        page: @validated_params[:page],
        year: @validated_params[:year],
        department: @validated_params[:department],
        name: @validated_params[:name]
      )
      query.perform()
    end
  end
end
