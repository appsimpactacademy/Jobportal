require "test_helper"

class DemoEmailMailerTest < ActionMailer::TestCase
  test "user_count" do
    mail = DemoEmailMailer.user_count
    assert_equal "User count", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
