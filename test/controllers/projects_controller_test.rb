# frozen_string_literal: true

require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project1 = create(:project)
    @project2 = create(:project)
  end

  test '#index renders index with a single project' do
    get '/'

    assert assigns(:project)
    assert_response :success
  end

  test '#projects renders no projects without valid params' do
    get '/projects'

    assert_response :success
    assert assigns(:projects).nil?
  end

  test '#projects renders projects from a valid set filter params' do
    get '/projects', params: { department: 'electrical', year: 2021 }

    assert_response :success
    assert_equal 2, assigns(:projects).count
  end

  test '#projects renders projects from search' do
    get '/projects', params: { name: @project1.title }

    assert_response :success
    assert_equal 2, assigns(:projects).count
  end
end
