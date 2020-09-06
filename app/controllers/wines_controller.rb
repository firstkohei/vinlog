class WinesController < ApplicationController
  before_action :correct_user, only: [:destroy]
  before_action :require_user_logged_in, only: [:new]
  
  def index
    @wines = Wine.order(id: :desc).page(params[:page]).per(9)
  end

  def show
    @wine = Wine.find(params[:id])
  end

  def new
    @wine = Wine.new
  end

  def create
    @wine = current_user.wines.build(wine_params)
    if @wine.save
      flash[:success] = 'ワインを投稿しました。'
      redirect_to @wine
    else
      @wines = current_user.wines.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'ワインの投稿に失敗しました。'
      render("wines/new")
    end
  end

  def edit
    @wine = Wine.find(params[:id])
  end

  def update
     @wine = Wine.find(params[:id])
     @wine.name = params[:name]
    if @wine.save
      flash[:success] = 'ワインを編集しました。'
      redirect_to @wines
    else
      @wines = current_user.wines.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'ワインの編集に失敗しました。'
      render 'wines/new'
    end
  end

  def destroy
    @wine.destroy
    flash[:success] = 'ワインを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def search
    @wines = Wine.search(params[:search])
  end
  
  private

  def wine_params
    params.require(:wine).permit(:name, :area, :taste, :grape, :content, :image, :color)
  end
  
  def correct_user
    @wine = current_user.wines.find_by(id: params[:id])
    unless @wine
      redirect_to root_url
    end
  end
end
