class Project < ApplicationRecord
    paginates_per 3

    has_many :people, dependent: :destroy

    validates :title, :abstract, :video_link, presence: true

    enum department: {
        electrical: 0,
        mechanical: 1,
        civil: 2,
        environmental: 3,
        industrial: 4,
    }
end
