class User < ApplicationRecord
  PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
/x
  PASS_MESSAGE = 'must contain 8 or more characters, a digit, a lower and an upper case character and a symbol'

  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,
            format: { with: PASSWORD_FORMAT, message: PASS_MESSAGE },
            confirmation: true,
            on: :create
end
