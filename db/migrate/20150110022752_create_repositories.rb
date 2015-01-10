class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :name
      t.string :url
      t.boolean :enabled
      t.integer :user_id

      t.timestamps
    end
  end
end
