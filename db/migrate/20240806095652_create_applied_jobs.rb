class CreateAppliedJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :applied_jobs do |t|
      t.references :job, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :cover_letter
      t.string :current_ctc
      t.string :expected_ctc
      t.string :contact_number
      t.string :estimated_joining_within
      t.boolean :serving_notice_period

      t.timestamps
    end
  end
end
