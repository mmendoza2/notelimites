module API::V101
    class RelationvenuesController <  API::BaseController
      skip_before_filter :verify_authenticity_token, :only => :create
      skip_before_filter :verify_authenticity_token, :only => :destroy

      def relations
        respond_to do |format|
          format.json {  render action: 'relations', relations: @relationvenues, status: 200 }
        end
      end

      def create
        @venue = Venue.find(params[:followed_id])
        @user =  User.find(params[:follower_id])
        if @user.followingvenue?(@venue)
          render :json => '{"followed": true}', status: 200
        else
          @user.followvenue!(@venue)
          respond_to do |format|
            format.json {  render :json => '{"followed": true}', relations: @relationvenues, status: 200 }
          end
        end
      end

      def destroy
        @venue = Venue.find(params[:followed_id])
        @user =  User.find(params[:follower_id])
        if @user.followingvenue?(@venue)
          @user.unfollowvenue!(@venue)
          respond_to do |format|
            format.json {  render :json => '{"followed": false}', relations: @relationvenues, status: 200 }
          end
        else
          render :json => '{"followed": false}', status: 200
        end
      end

      private
      # Never trust parameters from the scary internet, only allow the white list through.
      def relationvenue_params
        params[:relationvenues].permit( :follower_id, :followed_id, :created_at, :updated_at)
      end

    end
end