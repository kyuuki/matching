class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  def edit
    # TODO: 日本仕様
    # super の後だとダメ。
    resource.build_japan_user if resource.japan_user.nil?

    #super
    render :edit, layout: "mypage"
    # http://blog.goo.ne.jp/nakajima_notec/e/85cb60cb86323951384e1961f4c4726c
    # 入れ子のレイアウト
  end

  # PUT /resource
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      bypass_sign_in resource, scope: resource_name
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      #respond_with resource
      render :edit, layout: "mypage"
      # エラー時のレイアウトを切り替えるためだけに結局ソースを全部コピー。
      # https://github.com/plataformatec/devise/blob/master/app/controllers/devise/registrations_controller.rb
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # http://www.tom08.net/entry/2016/08/09/103957
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update,
      keys: [:account_name, :first_name, :last_name, :sex, :birthday,
             :address1, :address2, :address3, :phone, :phone_mobile,
             :profile, :profile_image,
             japan_user_attributes: [:id, :first_name_kana, :last_name_kana, :japan_prefecture_id]])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  # http://easyramble.com/redirect-account-setting-with-devise.html
  def after_update_path_for(resource)
    edit_user_registration_path
  end
end
