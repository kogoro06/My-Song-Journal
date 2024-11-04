class Journal < ApplicationRecord
  belongs_to :user

  validates :date, presence: true

  before_validation :set_default_date, on: :create

  private

  def set_default_date
    self.date ||= Date.today
  end
end
