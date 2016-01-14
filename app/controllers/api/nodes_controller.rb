module Api
  class NodesController < Api::BaseController
    def show
      render json: current_node
    end

    def update
      logger.debug("[Handshake][#{update_params[:hostname]}] #{update_params.inspect}")
      current_node.hostname = update_params[:hostname].to_s.strip
      current_node.last_access = DateTime.now
      current_node.report = update_params[:report]
      current_node.has_errors = update_params[:has_errors]
      current_node.update_ips(update_params[:ips])

      if current_node.save
        render json: current_node, status: :ok
      else
        render json: { errors: current_node.errors }, status: :unprocessable_entity
      end
    end

    private
    def update_params
      params.require(:node).permit(:hostname, :has_errors, :report, :ips => [:ip, :interface, :netmask])
    end

    def node_params
      params.require(:node).permit(:name)
    end
  end
end
