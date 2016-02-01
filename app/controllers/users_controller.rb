class UsersController < ApplicationController
  
  # edit, update の時は, Login しているかを先に確認する
  before_action :logged_in_user, only:[:edit, :update]
  before_action :matched_user, only:[:edit, :update]
  before_action :set_user, only:[:show, :edit, :update]
  
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
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
    
  end
  
  def update
    
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
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :origin, :profile)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  #ログイン中か確認 
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in first."
      redirect_to login_path
    end
  end
  
  # 正しいユーザーかチェック
  def matched_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user.id)
    end
  end
  
end
