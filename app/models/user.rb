class User < ApplicationRecord

  has_secure_password

  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, length: { minimum: 6}
  validates :password_confirmation, presence: true


end
