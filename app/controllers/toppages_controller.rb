class ToppagesController < ApplicationController
  def index
    @wines = Wine.order(id: :desc).page(params[:page]).per(4)
    render layout: 'toppage'
  end
  
  def about
    render layout: 'toppage'
  end
end
