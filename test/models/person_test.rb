require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  setup do
    @project = create(:project)
  end

  test '.save saves a person with valid parameters' do
    create(:person, name: 'Bobby Frank', project_id: @project.id)
  end

  test '.save does not save a person without a name' do
    exception = assert_raises ActiveRecord::RecordInvalid do
      create(:person, name: nil, project_id: @project.id)
    end

    assert_equal "Validation failed: Name can't be blank", exception.message
  end

  test '.save does not save a person without reference to a project_id' do
    exception = assert_raises ActiveRecord::RecordInvalid do
      create(:person, name: 'George McGeorge', project_id: nil)
    end

    assert_equal "Validation failed: Project must exist", exception.message
  end
end
