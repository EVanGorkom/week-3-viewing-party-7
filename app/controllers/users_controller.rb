class UsersController <ApplicationController 
  def new 
    @user = User.new
  end 

  def show 
    @user = User.find(params[:id])
  end 

  def create 
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to user_path(user)
    else  
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to register_path
    end 
  end 

  def login_form
  end

  def login_user
    @user = User.find_by(email: params[:email])
    if @user != nil && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}"
      redirect_to "/users/#{@user.id}"
    else
      flash[:error] = "Your email or password were incorrect, try again and be sure to check your spelling if you're dyslexic like me."
      redirect_to "/login"
    end
  end

  def logout
    require 'pry';binding.pry
  end

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end 