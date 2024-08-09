class Company < ApplicationRecord
  has_many :jobs

  def self.ransackable_attributes(auth_object = nil)
    ["address", "contact", "created_at", "id", "name", "updated_at"]
  end
end
