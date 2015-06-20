class AccountActivationsController < ApplicationController

	def edit
    user = User.find_by(email: params[:email])
    #Check that the user is not activated and is authenticated.
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate #Activate the user
      log_in user #Log in the user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
  
end
