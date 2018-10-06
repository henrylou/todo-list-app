class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :taskname
      t.timestamp :deadline
      t.integer :importance
      t.string :category
      t.integer :user_id

      t.timestamps
    end
  end
end
