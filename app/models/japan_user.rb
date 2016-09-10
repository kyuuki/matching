class JapanUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :japan_prefecture

  # Validation
  validates :first_name_kana,
    format: { with: /\A[ァ-ンー－]+\z/ },
    allow_blank: true
  validates :last_name_kana,
    format: { with: /\A[ァ-ンー－]+\z/ },
    allow_blank: true
end
