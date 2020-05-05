class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  # GET /resource/sign_up
  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @address = @user.build_address
    render :new_address
  end

  # def create_info
  #   @user = User.new(session["devise.regist_data"]["user"])
  #   @info = Info.new(info_params)
  #   unless @info.valid?
  #     flash.now[:alert] = @info.errors.full_messages
  #     render :new_info and return
  #   end
  #   @user.build_info(@info.attributes)
  #   @user.save
  #   session["devise.regist_data"]["user"].clear
  #   session["info"] = {info: @info.attributes}
  #   session["info"][:info]= params[:info]
  #   @address = Address.new
  #   render :new_address


  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(address_params)
    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    @user.build_address(@address.attributes)
    @user.save
    session["devise.regist_data"]["user"].clear
    sign_in(:user, @user)
    redirect_to root_path
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

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

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  # def info_params
  #   params.require(:info).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :birthday)
  # end

  def address_params
    params.require(:address).permit(:postal_code, :prefecture_id, :city, :house_number, :house_name)
  end

  # def birthday_join
  #   # パラメータ取得
  #   date = params[:user][:birthday]

  #   # ブランク時のエラー回避のため、ブランクだったら何もしない
  #   if date["birthday(1i)"].empty? && date["birthday(2i)"].empty? && date["birthday(3i)"].empty?
  #     return
  #   end

  #   # 年月日別々できたものを結合して新しいDate型変数を作って返す
  #   Date.new date["birthday(1i)"].to_i,date["birthday(2i)"].to_i,date["birthday(3i)"].to_i

  # end

  

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
