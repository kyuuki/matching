class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         # :omniauthable

  has_one :japan_user
  accepts_nested_attributes_for :japan_user

  mount_uploader :profile_image, ProfileImageUploader

  # Validation
  #validates :email, presence: true  # Devise 側でやってる
  validates :account_name,
    format: { with: /\A[A-Za-z0-9_\-]+\z/ },
    allow_nil: true
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

  def profile_image_url
    if profile_image.url.nil?
      "prof_noimg.jpg"
    else
      profile_image.url
    end
  end

  def can_buy_item?
    return false if account_name.nil?
    return false if first_name.nil?
    return false if japan_user.first_name_kana.nil?
    return false if last_name.nil?
    return false if japan_user.last_name_kana.nil?
    return false if sex.nil?
    return false if birthday.nil?
    return false if japan_user.japan_prefecture.nil?
    #return false if address1.nil?
    return false if address2.nil?
    #return false if address3.nil?
    return false if phone.nil? and phone_mobile.nil?
    return true
  end

  def can_sell_item?
    return false unless can_buy_item?
    return true
  end
end
