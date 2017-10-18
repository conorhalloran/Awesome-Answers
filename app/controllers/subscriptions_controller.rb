class SubscriptionsController < ApplicationController
    def new
        
    end
    def create
        # by setting an instance variable here, we're able to access its value in the associated view file. Recall that each request renders only one action which means other actions won;t be able to access this instance variable.
        @name = params[:name]
    end
end
