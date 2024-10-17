require "test_helper"

class ExportMailerTest < ActionMailer::TestCase
  test "send_exported_job_applications" do
    mail = ExportMailer.send_exported_job_applications
    assert_equal "Send exported job applications", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
