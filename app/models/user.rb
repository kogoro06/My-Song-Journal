class User < ApplicationRecord
  has_many :journals, dependent: :destroy
  has_one_attached :profile_image

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: %i[spotify]

  validates :uid, uniqueness: { scope: :provider }, if: -> { uid.present? }
  validates :name, presence: true
  validates :profile, length: { maximum: 200 }
  
  # Email validation with format and uniqueness
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  def self.from_omniauth(auth)
    # Search for a user by provider and uid, or find by email
    user = find_by(provider: auth.provider, uid: auth.uid) || find_by(email: auth.info.email)

    if user
      # Update existing user's provider and uid
      user.update(provider: auth.provider, uid: auth.uid)
    else
      # Create a new user with omniauth information
      user = create!(
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        password: Devise.friendly_token[0, 20],
        name: auth.info.name || "Unknown",
        # Telephone and date of birth should be added via UI
      )
    end
    user
  end

  def self.create_unique_string
    SecureRandom.uuid
  end
end
