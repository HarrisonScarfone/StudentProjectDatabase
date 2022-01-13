class SubmissionsController < ApplicationController
  def create
    render "submissions/create"
  end

  def create_download
    submission = generate_submission_package

    if submission.valid_submission?
      send_data submission.generate_json, filename: 'generated_submission.json', type: :json
    else
      redirect_to '/submissionCreate', alert: submission.error_messages_as_string
    end
  end

  private

  def generate_submission_package
    ::Submission::SubmissionPackage.new(
      action: params["action"],
      project_as_hash: {
        department: params['department'].downcase,
        video_link: params['videoLink'],
        title: params['title'],
        abstract: params['abstract'],
        year: params['year']
      },
      people_as_array: [
        params['groupMember1'],
        params['groupMember2'],
        params['groupMember3'],
        params['groupMember4']
      ]
    )
  end
end
