class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_one :japan_user
  accepts_nested_attributes_for :japan_user

  mount_uploader :profile_image, ProfileImageUploader

  # Validation
  #validates :email, presence: true  # Devise 側でやってる
  validates :account_name,
    format: { with: /\A[A-Za-z0-9_\-]+\z/ }
  validates :sex,
    inclusion: { in: [1, 2] },
    allow_nil: true
  validates :address1,
    length: { in: 0..40 },
    allow_nil: true
  validates :address2,
    length: { in: 0..40 },
    allow_nil: true
  validates :address3,
    length: { in: 0..40 },
    allow_nil: true
  validates :phone,
    length: { in: 0..30 },
    format: { with: /\A[0-9\-]+\z/ },
    allow_blank: true
  validates :phone_mobile,
    length: { in: 0..30 },
    format: { with: /\A[0-9\-]+\z/ },
    allow_blank: true
  validates :profile,
    length: { in: 0..400 },
    allow_blank: true

  def update_without_password(params, *options)
    # パスワード変更できるようにする
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
