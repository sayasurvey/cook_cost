class OauthsController < ApplicationController
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    unless (@user = login_from(provider))
      @user = create_from(provider)
      reset_session
      auto_login(@user)
    end
    redirect_to root_path, success: "#{provider.titleize}でログインしました"
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end
end
