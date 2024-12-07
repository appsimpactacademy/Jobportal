class CorrectUserRoleTypeForEmployers < ActiveRecord::Migration[7.0]
  def up
    User.where(role: 'employeer')
        .update_all(role: 'employer', updated_at: Time.now)
  end

  def down
    User.where(role: 'employeer')
  end
end
