# frozen_string_literal: true

class Person < ApplicationRecord
  belongs_to :project

  validates :name, presence: true
end
