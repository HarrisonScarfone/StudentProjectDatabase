class SubmissionsController < ApplicationController
    def create
        render "submissions/create"
    end

    def create_download
        validated_params = validate_params

        redirect_to '/submissionCreate' unless validated_params

        if validated_params
            data = generate_json
            send_data data, filename: 'generated_submission.json', type: :json
        end
    end

    private

    def validate_params        
        return false unless params["action"] == "create_download"

        return false unless
            params['department'].present? &&
            params['year'].present? &&
            params['title'].present? &&
            params['groupMember1'].present? &&
            params['abstract'].present? &&
            params['videoLink'].present?

        return false unless Project.new(
            department: params['department'].downcase,
            video_link: params['videoLink'],
            title: params['title'],
            abstract: params['abstract'],
            year: params['year']
        ).valid?

        true
    end

    def generate_json
        submission = {
            department: params['department'],
            year: params['year'],
            title: params['title'],
            abstract: params['abstract'],
            video_link: params['videoLink'],
            group_members: [
                params['groupMember1']
            ]
        }

        submission[:group_members] = submission[:group_members] + [params['groupMember2']] if params['groupMember2'].present?
        submission[:group_members] = submission[:group_members] + [params['groupMember3']] if params['groupMember3'].present?
        submission[:group_members] = submission[:group_members] + [params['groupMember4']] if params['groupMember4'].present?

        submission.to_json
    end

end
