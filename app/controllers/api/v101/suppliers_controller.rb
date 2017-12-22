module API::V101
    class SuppliersController <  API::BaseController

      def index
        @suppliers = Supplier.all
      end

      def show
        @supplier = Supplier.find(params[:id])
      end


    end
end
