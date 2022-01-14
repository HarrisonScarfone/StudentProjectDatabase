# frozen_string_literal: true

module Submission
  class SubmissionPackageTest < ActiveSupport::TestCase
    setup do
      @action = 'create_download'

      @project_as_hash = {
        department: 'electrical',
        video_link: 'https://www.youtube.com/embed/a46Ako2Y970',
        title: 'A' * 10,
        abstract: 'a' * 100,
        year: 2022
      }

      @people_as_array = [
        'Bob McBobbyBob',
        'Cindy McCindyCind'
      ]
    end

    test '.valid_submission? returns true for a valid submission package' do
      submission_package = Submission::SubmissionPackage.new(
        action: @action,
        project_as_hash: @project_as_hash,
        people_as_array: @people_as_array
      )

      assert submission_package.valid_submission?
    end

    test '.valid_submission? returns false without the create_download action' do
      submission_package = Submission::SubmissionPackage.new(
        action: 'invalid_action',
        project_as_hash: @project_as_hash,
        people_as_array: @people_as_array
      )

      assert !submission_package.valid_submission?
    end

    test '.valid_submission? returns false when no valid project is found' do
      submission_package = Submission::SubmissionPackage.new(
        action: @action,
        project_as_hash: {},
        people_as_array: @people_as_array
      )

      assert !submission_package.valid_submission?
    end

    test '.valid_submission? returns false when no people are found' do
      submission_package = Submission::SubmissionPackage.new(
        action: @action,
        project_as_hash: @project_as_hash,
        people_as_array: []
      )

      assert !submission_package.valid_submission?
    end

    test '.error_messages_as_string returns a single error message as a string' do
      submission_package = Submission::SubmissionPackage.new(
        action: {},
        project_as_hash: @project_as_hash,
        people_as_array: @people_as_array
      )

      assert submission_package.error_messages_as_string.instance_of?(String)
      assert_equal submission_package.error_messages_as_string, 'Incorrect action detected.'
    end

    test '.error_messages_as_string returns a multiple error messages as a string' do
      submission_package = Submission::SubmissionPackage.new(
        action: @action,
        project_as_hash: {},
        people_as_array: @people_as_array
      )

      expected_result = [
        "Video link can't be blank, Video link is not a valid youtube video embed link, T",
        "itle can't be blank, Title must be at least 10 characters, Abstract can't be blan",
        "k, Abstract must be at least 100 characters, Year can't be blank, Department ca",
        "n't be blank"
      ].join

      assert submission_package.error_messages_as_string.instance_of?(String)
      assert_equal submission_package.error_messages_as_string, expected_result
    end

    test '.error_messages_as_string returns nothing when submission_package is valid' do
      submission_package = Submission::SubmissionPackage.new(
        action: @action,
        project_as_hash: @project_as_hash,
        people_as_array: @people_as_array
      )

      assert submission_package.error_messages_as_string.blank?
    end

    test '.generate_json converts a submission_package to a json and returns it' do
      submission_package = Submission::SubmissionPackage.new(
        action: @action,
        project_as_hash: @project_as_hash,
        people_as_array: @people_as_array
      )

      expected_result = [
        '{"department":"electrical","year":2022,"title":"AAAAAAAAAA",',
        '"abstract":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        'aaaaaaaaaaaaaaaaaaaaaaaaaa","video_link":"https://www.youtube.com/embed/a46Ako2Y970",',
        '"group_members":["Bob McBobbyBob","Cindy McCindyCind"]}'
      ].join

      assert_equal submission_package.generate_json, expected_result
    end

    test '.generate_json does not generate a json if the submission package is not valid' do
      submission_package = Submission::SubmissionPackage.new(
        action: @action,
        project_as_hash: {},
        people_as_array: @people_as_array
      )

      assert_nil submission_package.generate_json
    end
  end
end
