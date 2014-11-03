module Api
  class  RegistrationController < Api::BaseController
    def check_authentication
      _access_denied unless current_user
    end

    def current_user
      if Settings['api']['token'] == request.headers['X-Authentication-Token']
        User.find_by(email: Settings['api']['user'])
      end
    end

    def create
      node = Node.create(node_params)
      if node.save
        render json: node, status: :ok, serializer: Api::NodeSerializer
      else
        render json: {errors: 'error'}, status: 400
      end
    end

    private
    def node_params
      params.require(:node).permit(:name)
    end
  end
end
