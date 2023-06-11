class CreateDownloads < ActiveRecord::Migration[6.1]
  def change
    create_table :downloads do |t|
      t.string :project
      t.string :user
      t.timestamp :time_started
      t.timestamp :time_finished
      t.integer :num_issues
      t.integer :num_files
      t.string :messages
      t.integer :result
    end
  end
end
