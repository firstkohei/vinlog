class UsersController < ApplicationController
  def index
    @users = User.order(id: :desc).page(params[:page]).per(8)
  end

  def show
    @user = User.find(params[:id])
    @wines = @user.wines.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = 'Profileが更新されました'
      redirect_to @user
    else
      flash.now[:danger] = 'Profileが更新されませんでした'
      render :edit
    end
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.favorited.page(params[:page])
    counts(@user)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password_digest, :password_confirmation, :profile)
  end
end
