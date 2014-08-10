class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # def self.provides_callback_for(provider)
  #   class_eval %Q{
  #     def #{provider}
  #       @user = User.find_for_oauth(env["omniauth.auth"], current_user)

  #       if @user.persisted?
  #         sign_in(@user)
  #         set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
  #         redirect_to root_url
  #       else
  #         raise "hello"
  #         session["devise.#{provider}_data"] = env["omniauth.auth"]
  #         redirect_to new_user_registration_url
  #       end
  #     end
  #   }
  # end
  def facebook
    @user = User.find_for_oauth(env["omniauth.auth"], current_user)

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?  
    else
      
      session["devise.facebook_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end


  def after_sign_in_path_for(resource)
    if resource.email_verified?
      new_message_url
    else
      finish_signup_path(resource)
    end
  end
end