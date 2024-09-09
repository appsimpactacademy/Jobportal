class CreateUserSavedJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :user_saved_jobs do |t|
      t.references :job, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :removed_from_favourite_at

      t.timestamps
    end
  end
end
