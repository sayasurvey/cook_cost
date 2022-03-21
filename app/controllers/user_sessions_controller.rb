class UserSessionsController < ApplicationController
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to root_path, success: 'ログインに成功しました'
    else
      flash.now['danger'] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    logout
    redirect_to boards_path, success: 'ログアウトしました'
  end
end