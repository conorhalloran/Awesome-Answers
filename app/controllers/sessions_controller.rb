class SessionsController < ApplicationController
    def new
    end

    def create
        # We have the user's email & password from the params
        # 1. Find the user by their email
        # 2. If a user is found, we'll verify their password

        user = User.find_by(email: session_params[:email])

        if user && user.authenticate(session_params[:password])
            session[:user_id] = user.id

            flash[:notice] = 'Thank you for signing in!'
            redirect_to root_path
        else
            # The method `.now` on flash will tell to exist only for the duration
            # of the current request instead of the next request as well
            flash.now[:alert] = 'Wrong email or password!'
            render :new
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: 'Signed Out!'
    end

    private
    def session_params
        params.require(:session).permit(:email, :password)
    end
end