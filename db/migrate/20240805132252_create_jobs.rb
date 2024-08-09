class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.string :job_type
      t.string :applicable_for
      t.string :link_to_apply
      t.string :salary_range
      t.string :job_location
      t.string :status
      t.integer :total_positions
      t.integer :posted_by_id
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
