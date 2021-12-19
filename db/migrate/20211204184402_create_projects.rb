class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :abstract
      t.string :video_link
      t.integer :department
      t.integer :year

      t.timestamps
    end
  end
end
