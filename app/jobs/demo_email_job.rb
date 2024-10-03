class DemoEmailJob < ApplicationJob
  queue_as :default

  def perform(users, jobs, applications)
    total_users = users.count
    job_count = jobs.count
    application_count = applications.count
    DemoEmailMailer.user_count(total_users, job_count, application_count).deliver_later
  end
end
