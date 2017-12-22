class RelationeventsController < ApplicationController
  def create
    @event = Event.find(params[:relationevent][:followed_id])
    current_user.followevent!(@event)
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.js
      format.json
    end
  end

  def destroy
    @event = Relationevent.find(params[:id]).followed
    current_user.unfollowevent!(@event)
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.js
      format.json
    end
  end



  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def relationevent_params
    params[:relationevents].permit( :follower_id, :followed_id, :created_at, :updated_at)
  end


end