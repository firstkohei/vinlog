class ToppagesController < ApplicationController
  
  def index
    @wines = Wine.order(id: :desc).limit(3)
    render layout: 'toppage'
  end
  
  def about
    render layout: 'toppage'
  end
end
