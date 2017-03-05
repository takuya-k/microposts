class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to user_path(@user[:id])

    else
      render 'new'
    end
  end
  
  def show
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def edit
    if @user.id != current_user.id
      redirect_to root_path
    end
  end
  
  def update
    if @user.id != current_user.id
      redirect_to root_path
    else
      if @user.update(user_params)
        flash[:success] = "Profile changed"
        redirect_to user_path(@user[:id])
      else
        render 'edit'
      end
    end 
  end

  #-----------------------
  #ここからprivateメソッド
  #-----------------------
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :area, :birthday)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end