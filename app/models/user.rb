class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable
  
  belongs_to :company, optional: true

  has_many :user_saved_jobs
  has_many :jobs, through: :user_saved_jobs

  validates :first_name, :last_name, presence: true
  validates :contact_number, presence: true, uniqueness: true

  validate :company_required_if_employeer

  def employeer?
    role == 'employeer'
  end

  def job_seeker?
    role == 'job_seeker'
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  private

  def company_required_if_employeer
    if employeer? && company.nil?
      errors.add(:company, "must exist if user is an employer")
    end
  end
end
