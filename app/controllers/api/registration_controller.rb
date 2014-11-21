module Api
  class  RegistrationController < Api::BaseController
    def check_authentication
      _access_denied unless current_user
    end

    def current_user
      user = User.find_by(access_key: request.headers['X-Authentication-Key'])
      user if user &&  user.access_token == request.headers['X-Authentication-Token']
    end

    def create
      node = Node.find_or_create_by(name: node_params['name'])
      if node.save
        render json: node, status: :ok, serializer: Api::NodeSerializer
      else
        render json: {errors: node.errors}, status: 400
      end
    end

    private
    def node_params
      params.require(:node).permit(:name)
    end
  end
end
