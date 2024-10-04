class DeleteFavouriteJobNotificationJob < ApplicationJob
  queue_as :default

  def perform(users, title, company)
    users.each do |user|
      NotificationMailer.when_a_user_favourite_job_removed(user, job_title, company).deliver_now
    end
  end
end
