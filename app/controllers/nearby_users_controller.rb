class NearbyUsersController < ApplicationController
  def index
    if params[:longitude] && params[:latitude]
      session[:longitude] = params[:longitude].to_f
      session[:latitude] = params[:latitude].to_f
    end
    if session[:latitude] && session[:longitude]
      @users = User.near([session[:latitude], session[:longitude]], 20, units: :km)
      @hash = Gmaps4rails.build_markers(@users) do |user, marker|
        marker.lat user.latitude
        marker.lng user.longitude
        marker.infowindow "<a href='#{user_path(user)}'>#{user.full_name}</a>"
      end
    end
  end
end
