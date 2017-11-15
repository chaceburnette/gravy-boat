class UsersController < AdminController
  before_action :find_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def edit
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render :edit, notice: 'Patient was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)

      @user.user_role.delete_all
      UserRole.new(user: @user, role: Role.where(name: Role::ADMIN).first).save if role_params[:admin] == "1"
      UserRole.new(user: @user, role: Role.where(name: Role::UPLOADER).first).save if role_params[:uploader] == "1"
      UserRole.new(user: @user, role: Role.where(name: Role::IMAGE_VIEWER).first).save if role_params[:image_viewer] == "1"
      UserRole.new(user: @user, role: Role.where(name: Role::TEAM_VIEWER).first).save if role_params[:team_viewer] == "1"
      redirect_to edit_user_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private
    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password)
    end

    def role_params
      params.require(:user).permit(:admin, :uploader, :image_viewer, :team_viewer)
    end
end
