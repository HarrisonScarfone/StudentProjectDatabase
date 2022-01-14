# frozen_string_literal: true

module Submission
  class SubmissionPackage
    def initialize(action:, project_as_hash:, people_as_array:)
      @action = action
      @project_as_hash = project_as_hash
      @people_as_array = people_as_array

      @project = nil
      @people = []

      @errors = []

      attach_errors
    end

    def valid_submission?
      @action && (@project.nil? ? false : @project&.valid?) && @people.any?
    end

    def error_messages_as_string
      @errors&.join(', ')
    end

    def generate_json
      return unless valid_submission?

      submission = {
        department: @project['department'],
        year: @project['year'],
        title: @project['title'],
        abstract: @project['abstract'],
        video_link: @project['video_link'],
        group_members: []
      }

      @people_as_array.each do |person|
        submission[:group_members] = submission[:group_members] + [person] unless person.blank?
      end

      submission.to_json
    end

    private

    def attach_errors
      attach_action_error
      attach_project_errors
      attach_people_errors
    end

    def attach_action_error
      if @action != 'create_download'
        @errors.append('Incorrect action detected.')
        @action = false
      end
    end

    # if the person model changes to include errors, messages should be included here
    def attach_project_errors
      project = Project.new(
        department: @project_as_hash[:department]&.downcase,
        video_link: @project_as_hash[:video_link],
        title: @project_as_hash[:title],
        abstract: @project_as_hash[:abstract],
        year: @project_as_hash[:year]
      )

      if project.valid?
        @project = project
      else
        @errors += project&.errors&.full_messages
      end
    end

    # a person is just a string containing a name right now, can be converted to a hash to store more info
    def attach_people_errors
      @people_as_array.each do |person|
        person_model = Person.new(name: person)

        if person_model.name
          @people.append(person_model)
        else
          @errors += person_model&.errors&.full_messages
        end
      end
    end
  end
end
