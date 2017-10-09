class AdminController < AuthController
  before_action :ensure_admin

  def ensure_admin
    if !@current_user.admin?
      redirect_to root_path
    end
  end
end