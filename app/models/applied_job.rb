class AppliedJob < ApplicationRecord
  JOINING_DURATION = ['Immediate', '1 Week', '15 Days', '1 Month', '2 Month']

  belongs_to :job
  belongs_to :job_seeker, class_name: 'User', foreign_key: 'user_id'

  validates :cover_letter, :expected_ctc, :current_ctc, :contact_number, presence: true
end
