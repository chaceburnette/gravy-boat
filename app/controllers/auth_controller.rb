class AuthController < ApplicationController
  before_action :ensure_logged_in

  def ensure_logged_in
    if !logged_in?
      redirect_to root_path
    end
  end
end
