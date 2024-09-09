class UserSavedJob < ApplicationRecord
  belongs_to :job
  belongs_to :job_seeker, class_name: 'User', foreign_key: 'user_id'
end
