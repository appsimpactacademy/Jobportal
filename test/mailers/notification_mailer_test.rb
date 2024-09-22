require "test_helper"

class NotificationMailerTest < ActionMailer::TestCase
  test "when_new_job_created" do
    mail = NotificationMailer.when_new_job_created
    assert_equal "When new job created", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
