module API::V101
    class CategoriesController <  API::BaseController

      def index
        @categories = Category.all
      end

      def show
        @category = Category.find(params[:id])
      end

    end
end
