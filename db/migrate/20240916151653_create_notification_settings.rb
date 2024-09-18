class CreateNotificationSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_settings do |t|
      t.boolean :on_new_job_post
      t.boolean :on_removal_of_favourite_job
      t.boolean :on_removal_of_existing_job
      t.boolean :on_status_changed_on_applied_job
      t.boolean :on_job_status_change
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
