class User < ApplicationRecord
  has_many :journals, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: %i[spotify]

  validates :uid, uniqueness: { scope: :provider }, if: -> { uid.present? }
  validates :name, presence: true #追記
  validates :profile, length: { maximum: 200 } #追記

  def self.from_omniauth(auth)
    # まず、providerとuidでユーザーを検索
    user = where(provider: auth.provider, uid: auth.uid).first

    # 見つからなければ、emailで検索して既存ユーザーを確認
    user ||= find_by(email: auth.info.email)

    if user
      # 既存のユーザー情報を更新
      user.update(provider: auth.provider, uid: auth.uid)
    else
      # 新しいユーザーを作成
      user = create!(
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        password: Devise.friendly_token[0, 20],
        name: auth.info.name || "Unknown",
        telephone_number: "00000000000",
        date_of_birth: "1997-01-01"
      )
    end
    user
  end

  def self.create_unique_string
    SecureRandom.uuid
  end
end
