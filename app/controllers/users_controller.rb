class UsersController < ApplicationController
  
  # edit, update の時は, Login しているかを先に確認する
  before_action :logged_in_user, only:[:edit, :update]
  
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    #Userクラスの新しいインスタンスを作成して、UsersControllerのインスタンス変数@userに代入
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else 
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(edit_user_params)
      flash[:success] = "Your profile was updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def edit_user_params
    params.require(:user).permit(:name, :email, :origin, :profile)
  end
  
  #ログイン中か確認 
  def logged_in_user
    unless logged_in
      flash[:danger] = "Please log in first."
      redirect_to login_path
    end
  end
end
