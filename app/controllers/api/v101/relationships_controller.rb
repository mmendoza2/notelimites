module API::V101
    class RelationshipsController <  API::BaseController
      skip_before_filter :verify_authenticity_token, :only => :create
      skip_before_filter :verify_authenticity_token, :only => :destroy

      def relations
        @followed_user = User.find(params[:followed_id])
        @user =  User.find(params[:follower_id])
        if @user.following?(@followed_user)
          render :json => 'Ya existe', status: 200
        else
          render :json => 'No existe', status: 200
        end
      end

      def create
        @followed_user = User.find(params[:followed_id])
        @user =  User.find(params[:follower_id])
        if @user.following?(@followed_user)
          render :json => 'Ya existe', status: 200
        else
          @user.follow!(@followed_user)
          respond_to do |format|
            format.json {  render :json => 'Creado', relations: @relations, status: 200 }
          end
        end
      end

      def destroy
        @followed_user = User.find(params[:followed_id])
        @user =  User.find(params[:follower_id])
        if @user.following?(@followed_user)
          @user.unfollow!(@followed_user)
          respond_to do |format|
            render :json => 'Ya existe', status: 200
          end
        else
          render :json => 'No existe', status: 200
        end
      end

      private
      # Never trust parameters from the scary internet, only allow the white list through.
      def relationships_params
        params[:relationships].permit( :follower_id, :followed_id, :created_at, :updated_at)
      end

    end
end