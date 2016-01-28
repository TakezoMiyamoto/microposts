class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password]) #authenticateメソッドでパスワードが正しいか調べます
      #session[:user_id]にユーザーIDを入れ、ユーザーの詳細ページにリダイレクトします。
      session[:user_id] = @user.id
      flash[:info] = "logged in as #{@user.name}"
      redirect_to @user
    else
      #パスワードが間違っている場合は’new’テンプレートを表示
      flash[:danger] = "invalid email/password combination"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil #サーバーとブラウザの両方でセッションの情報を破棄
    redirect_to root_path
  end
end
