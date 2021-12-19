module Projects
    class ProjectsQueryTest < ActiveSupport::TestCase
        setup do
            @project1 = create(:project)
            @project2 = create(:project)
            @project3 = create(:project, department: 'mechanical')
        end

        test '.preform returns projects based on valid filter params' do
            result = Projects::ProjectsQuery.new(department: 'electrical', year: 2021, page: nil, name: nil).perform()
            
            assert_not_nil result
            assert_equal 2, result.count()
        end

        test '.perform returns no projects with invalid department' do
            result = Projects::ProjectsQuery.new(department: 'invalid department', year: 2021, page: nil, name: nil).perform()
            
            assert_not_nil result
            assert_equal 0, result.count()
        end

        test '.perform returns no projects with invalid year' do
            result = Projects::ProjectsQuery.new(department: 'electrical', year: 'not a valid year', page: nil, name: nil).perform()
            
            assert_not_nil result
            assert_equal 0, result.count()
        end

        test '.perform returns no projects with invalid department and invalid year' do
            result = Projects::ProjectsQuery.new(department: 'invalid department', year: 'invalid year', page: nil, name: nil).perform()
            
            assert_not_nil result
            assert_equal 0, result.count()
        end

        test '.perform returns projects based on a name search' do
            person = create(:person, project_id: @project3.id)

            result = Projects::ProjectsQuery.new(department: nil, year: nil, page: nil, name: person.name).perform()

            assert_not_nil result
            assert_equal 1, result.count()
        end

        test '.perform returns no projects when name is not found' do
            person = create(:person, project_id: @project3.id)

            result = Projects::ProjectsQuery.new(department: nil, year: nil, page: nil, name: 'not a valid name').perform()

            assert_not_nil result
            assert_not_equal person.name, 'not a valid name'
            assert_equal 0, result.count()
        end
    end
end
  