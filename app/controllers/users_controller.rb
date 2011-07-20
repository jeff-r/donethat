class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    puts @user.inspect
  end

  def update
    puts "user: "
    user = User.find(params[:id])

    respond_to do |format|
      if user.update_attributes(params[:user])
        format.html { redirect_to(user, :notice => "User was updated.") }
      else
        format.html { redirect_to(user, :notice => "User was not updated.") }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

end
