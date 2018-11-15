class User < ApplicationRecord
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :email, :password_digest, :session_token, presence: true

  attr_reader :password

  after_initialize :ensure_session_token


  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)

    user && user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    token = SecureRandom.urlsafe_base64(16)

    # Regenerates the token in case there is a conflict
    while self.class.exists?(session_token: token)
      token = SecureRandom.urlsafe_base64(16)
    end
    token
  end

  def reset_token_session!
    self.session_token = self.class.generate_session_token

    # Tries to save the current user with updated attributes
    save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def password=(password)
    @password = password
    # Hashes the given user password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt.new(self.password_digiest).is_password?(password)
  end
end
