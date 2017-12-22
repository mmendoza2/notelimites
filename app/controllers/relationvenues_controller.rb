class RelationvenuesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @venue = Venue.find(params[:relationvenue][:followed_id])
    current_user.followvenue!(@venue)
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.js
    end

  end

  def destroy
    @venue = Relationvenue.find(params[:id]).followed
    current_user.unfollowvenue!(@venue)
    respond_to do |format|
      format.html { redirect_to(:back)}
      format.js
    end

  end

end