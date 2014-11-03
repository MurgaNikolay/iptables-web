module Api
  class  NodesController < Api::BaseController
    def show
      render json: current_node
    end

    def update
      current_node.hostname = update_params[:hostname].to_s.strip
      current_node.ips.map(&:destroy)
      current_node.last_access = DateTime.now
      update_params[:ips].each do |iface|
        current_node.ips.push(NodeIp.create(iface))
      end
      if current_node.save
        render json: current_node, status: :ok
      else
        render json: {errors: current_node.errors}, status: :unprocessable_entity
      end
    end

    private
    def update_params
      params.require(:node).permit(:hostname, :ips => [:ip,:interface,:netmask])
    end

    def node_params
      params.require(:node).permit(:name)
    end
  end
end
