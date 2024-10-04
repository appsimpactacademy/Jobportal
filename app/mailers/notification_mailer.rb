class NotificationMailer < ApplicationMailer

  def when_new_job_created(user, job)
    @user = user
    @job = job

    mail(to: @user.email, subject: "A new job posted: #{@job.title}")
  end

  def when_a_user_favourite_job_removed(user, job_title, company)
    @user = user
    @title = job_title
    @company = company

    mail(to: @user.email, subject: "Removal of #{job_title} from the portal")
  end

  def when_an_applied_job_status_changed(user, job)
    @user = user
    @job = job

    mail(to: @user.email, subject: "Job Status changed on: #{@job.title}")
  end

  def job_application_receive_to_employeer(user, job)
    @user = user
    @job = job
    @employeer = @job.posted_by

    mail(to: @employeer.email, subject: "New application received on job: #{@job.title}")
  end

  def job_applied_by_job_seeker(user, job)
    @user = user
    @job = job

    mail(to: @user.email, subject: "Thanks for applying for: #{@job.title}")
  end
end
