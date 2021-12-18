class AddPeopleToProject < ActiveRecord::Migration[6.0]
  def change
    add_index :people, :project_id
  end
end
