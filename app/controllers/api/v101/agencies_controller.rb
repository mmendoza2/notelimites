module API::V101
  class AgenciesController <  API::BaseController

    def index
      @agencies = Agencie.all
    end

  end
end
