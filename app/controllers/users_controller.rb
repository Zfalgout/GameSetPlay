class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers, :show]
  before_action :correct_user,   only: [:edit, :update, :destroy]
  # before_action :admin_user,     only: :destroy

  def new
  	@user = User.new
  end

  def index
    #@users = User.paginate(page: params[:page])
    if params[:search]
      @users = User.search(params[:search]).paginate(page: params[:page])
    else
      @users = User.paginate(page: params[:page])
    end
  end

  def show
    @user = User.find(params[:id])
    @deletedMatchesPast = Match.where("player2 = ? OR player3 = ? OR player4 = ? OR validated = ?",  "Player 2", "Player 3", "Player 4", 0).where(time: 3.years.ago..Time.now).destroy_all #Delete matches in the past that have not been joined.
    @deletedMatchesFuture = Match.where("player2Accept = ? OR player3Accept = ? OR player4Accept = ?",  0, 0, 0).where(time: Time.now..3.years.from_now).destroy_all #Delete future unaccepted matches.
    @matches = Match.where("player1 = ? OR player2 = ? OR player3 = ? OR player4 = ?",  "#{@user.id}", "#{@user.id}", "#{@user.id}", "#{@user.id}").where("p2Active = ? AND p3Active = ? AND p4Active = ?", 1, 1, 1).all.paginate(page: params[:page]).order(time: :desc) #Only show matches that the user is in that all players have accepted an invite to.
    #@matches = Match.where("player1 = ? OR player2 = ? OR player3 = ? OR player4 = ?",  "#{@user.id}", "#{@user.id}", "#{@user.id}", "#{@user.id}").all.paginate(page: params[:page]).order(time: :desc)
  end

  def create
    @user = User.new(user_params) 
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :age, :zip, :NTRP_rating,
                                   :years_played, :about, :gender, :preference_of_play,
                                   :user_rating, :wins, :losses, :win_pct, :total_matches_played,
                                   :tournament_matches_won, :tournament_matches_lost, 
                                   :tournaments_won, :challenge_matches_won, :challenge_matches_lost,
                                   :challenges_posted, :challenges_accepted, :num_friends, :invalids)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
