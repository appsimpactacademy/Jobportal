class Company < ApplicationRecord
  has_many :jobs
  validates :name, presence: true, uniqueness: true
  validates :address, :contact, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["address", "contact", "created_at", "id", "name", "updated_at"]
  end

  def self.params
    %i[name address contact website domain about]
  end
end
