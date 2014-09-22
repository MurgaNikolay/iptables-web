module Api
  class BaseController < ApplicationController

    def _access_denied
      render json: {error: 'Access denied!'}, status: 401
    end

    def _load_node

    end
  end
end
