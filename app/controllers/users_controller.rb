class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new user_params
        if @user.save
            session[:user_id] = @user.id
            # The `flash` is a global object used store information that will be available for next request made to the server by the current browser.
            # flash[:notice] = 'Thank you for signing up' 👇 = shortcut for 👈

            redirect_to root_path, notice: 'Thank you for signing up!'
        else
            render :new
        end
    end

    def show
        @user = User.find params[:id]
    end

    private 
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :street, :city, :province, :postal, :country)
    end
end
