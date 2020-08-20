class ApplicationController < ActionController::Base
    
  include SessionsHelper
    
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end

  def counts(user)
    @count_wines = user.wines.count
    @count_favorited = user.favorited.count
  end
end
