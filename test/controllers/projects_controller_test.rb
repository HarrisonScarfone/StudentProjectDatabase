require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  test '#index renders index with a single project' do
    get '/'

    assert assigns(:project)
    assert_response :success
  end

  test '#projects renders projects when given' do 

  byebug 
    get '/projects'

    byebug
    assert_response :success
  end
end
