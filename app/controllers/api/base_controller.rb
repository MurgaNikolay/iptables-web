module Api
  class BaseController < ApplicationController
    skip_before_action :verify_authenticity_token

    def check_authentication
      _access_denied unless current_node
    end

    def _access_denied
      render json: {error: 'Access denied!'}, status: 401
    end

    def current_node
      @node ||= Node.find_by(token: request.headers['X-Node-Access-Token'] || params['access_token'])
    end
  end
end
