# frozen_string_literal: true

require 'test_helper'

class SubmissionsControllerTest < ActionDispatch::IntegrationTest
  test '#create renders a form successfully' do
    get '/submissionCreate'

    assert_response :success
  end

  test '#create_download creates a download with valid form parameters' do
    params = {
      title: 'Some Rando Project',
      abstract: "this is a test abstract of a project.  is it about a project where we did a project and had fun
          doing the project! this is some more text just to see how it handles a longer paragraph.  did i mention
          that it was about a project that we made that was a project because we had to make a project? anyways
          this is my project",
      videoLink: 'https://www.youtube.com/embed/a46Ako2Y970',
      department: 'electrical',
      year: 2021,
      groupMember1: 'Bob McFred',
      groupMember2: 'Linda McLisa'
    }

    get '/createDownload', params: params

    assert_response :ok
  end

  test '#create_download triggers a redirect with invalid form parameters' do
    params = {
      title: 'Some Rando Project',
      abstract: "this is a test abstract of a project.  is it about a project where we did a project and had fun
          doing the project! this is some more text just to see how it handles a longer paragraph.  did i mention
          that it was about a project that we made that was a project because we had to make a project? anyways
          this is my project",
      videoLink: 'NOT A VALID LINK',
      department: 'electrical',
      year: 2021,
      groupMember1: 'Bob McFred',
      groupMember2: 'Linda McLisa'
    }

    get '/createDownload', params: params

    assert_response :found
  end
end
