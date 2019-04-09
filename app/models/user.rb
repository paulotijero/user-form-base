class User < ApplicationRecord
  validates :first_name, presence: true, length: { in: 2..60 }
  validates :last_name, presence: true, length: { in: 2..60 }
  validates :username, presence: true, uniqueness: true, length: { in: 2..20 }
  validates :email, presence: true, uniqueness: true, confirmation: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :email_confirmation, presence: true
  validates :password, presence: true, confirmation: true, length: { minimum: 8 }, format: { with: /.*[0-9].*/ }
  validates :password_confirmation, presence: true
  validates :password_hint, length: { maximum: 100 }

  before_save :validate_name

  def full_name
    "#{first_name} #{last_name}"
  end

  def validate_name
    self.first_name = capitalize(self.first_name)
    self.last_name = capitalize(self.last_name)
  end

  def capitalize(name)
    ignore = [
      "de", 
      "la", 
      "del"
    ]
    name = name.split(" ").map do |val|
      ignore.include?(val.downcase) ? val.downcase : val.capitalize
    end
    name.join(" ")
  end

end
