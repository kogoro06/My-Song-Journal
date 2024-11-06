class Journal < ApplicationRecord
  belongs_to :user, optional: true # ユーザーをオプションにする
  belongs_to :emotion, optional: true

  # 新規作成時のバリデーション
  validates :date, presence: true
  validates :title, presence: true, length: { maximum: 255 }, if: :new_record?
  
  # 更新時のバリデーション
  validates :body, presence: true, length: { maximum: 65_535 }, unless: :new_record?

  before_validation :set_default_date, on: :create

  private

  def set_default_date
    self.date ||= Date.today
  end
end
