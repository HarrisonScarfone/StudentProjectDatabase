class Project < ApplicationRecord
    paginates_per 3

    has_many :people, dependent: :destroy

    enum department: {
        electrical: 0,
        mechanical: 1,
        civil: 2,
        environmental: 3,
        industrial: 4,
    }

    validates :video_link, presence: true, format: { 
        with: /https:\/\/www\.youtube\.com\/embed\/[a-zA-Z0-9]+/,
        message: 'is not a valid youtube video embed link'
    }

    validates :title, presence: true, format: {
        with: /.{10,}/,
        message: 'must be at least 10 characters'
    } 
    
    validates :abstract, presence: true, format: {
        with: /.{100,}/,
        message: 'must be at least 100 characters'
    }

    validates :department, presence: true
end
