class UsersController < ApplicationController
  
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
    
  end
  
  def update
    current_user.update(user_params)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
