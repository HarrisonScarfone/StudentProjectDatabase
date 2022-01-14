# frozen_string_literal: true

class AddProjectIdToPerson < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :project_id, :integer
  end
end
