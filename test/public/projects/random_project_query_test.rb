module Projects
    class RandomProjectQueryTest < ActiveSupport::TestCase
        test '.perform returns only 1 project' do
            project1 = create(:project)
            project2 = create(:project)

            result = Projects::RandomProjectQuery.new().perform()

            assert_not_nil result
            assert_not_equal Array, result.class
            assert_equal Project, result.class
        end

        test '.perform returns no projects if there are no projects' do
            result = Projects::RandomProjectQuery.new().perform()

            assert_nil result
        end
    end
end
  