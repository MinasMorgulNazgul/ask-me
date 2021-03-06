require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new

  attr_accessor :password

  has_many :questions, dependent: :destroy

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true

  validates :username, length: { maximum: 40 }, format: { with: /\A\w+\z/ }

  validates :color, format: { with: /\A#\h{3}{1,2}\z/ }, allow_nil: true

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password, presence: true, on: :create

  validates_confirmation_of :password

  before_validation :downcase_email_and_username

  before_save :encrypt_password

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    return nil unless user.present?

    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )

    return user if user.password_hash == hashed_password

    nil
  end

  private

  def downcase_email_and_username
    username&.downcase!
    email&.downcase!
  end

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(
        OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          password, password_salt, ITERATIONS,
          DIGEST.length, DIGEST
        )
      )
    end
  end
end
