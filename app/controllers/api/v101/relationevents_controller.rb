module API::V101
  class RelationeventsController <  API::BaseController
    skip_before_filter :verify_authenticity_token, :only => :create
    skip_before_filter :verify_authenticity_token, :only => :destroy

      def relations
        @relationevents = Relationevent.all
          respond_to do |format|
            format.json {  render action: 'relations', relations: @relationevents, status: 200 }
          end

      end

      def create
         @event = Event.find(params[:followed_id])
         @user =  User.find(params[:follower_id])
         if @user.followingevent?(@event)
           render :json => '{"followed": true}', status: 200
         else
           @user.followevent!(@event)
           respond_to do |format|
             format.json {  render :json => '{"followed": true}', relations: @relationevents, status: 200 }
           end
         end
      end

      def destroy
        @event = Event.find(params[:followed_id])
        @user =  User.find(params[:follower_id])
        if @user.followingevent?(@event)
          @user.unfollowevent!(@event)
          respond_to do |format|
            format.json {  render :json => '{"followed": false}', relations: @relationevents, status: 200 }
          end
        else
            render :json => '{"followed": false}', status: 200
        end
      end

      private
      # Never trust parameters from the scary internet, only allow the white list through.
      def relationevent_params
        params[:relationevents].permit( :follower_id, :followed_id, :created_at, :updated_at)
      end

  end
end