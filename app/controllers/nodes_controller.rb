class NodesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index

    if params[:term]
      query = Node.joins('LEFT OUTER JOIN node_ips ON nodes.id = node_ips.node_id')
      .where('name LIKE ? OR hostname LIKE ? OR ip LIKE ?',
        "#{params[:term]}%", "#{params[:term]}%", "#{params[:term]}%"
      )
      render json: query.map(&:attributes)
    else
      render json: context.all
    end
  end

  def destroy
    node = Node.find(params[:id])
    respond_to do |format|
      if node.destroy
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: node.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    render json: Node.find(params[:id])
  end

  def update
    node = Node.find(params[:id])
    return render :status => 404 unless node

    node.assign_attributes(update_params)
    if node.save
      render json: node
    else
      render json: {errors: node.errors}, status: :unprocessable_entity
    end
  end

  def access_rules
    node = Node.find(params[:id])
    node.access_rules
  end

  def create
    node = Node.create(update_params)
    if node.save
      redirect_to node_url(node)
    else
      render json: {errors: 'error'}, status: 400
    end
  end

  private
  def node_params
    params.require(:node).permit(:id, :name, :description, :access_rules => [
        :id, :port, :ip, :protocol, :description
        ], :security_groups => [:name, :id]
    )
  end

  def update_params
    params.require(:node).permit(:name, :description, :token)
  end

  def context
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return @context ||= $1.classify.constantize.find(value).nodes
      end
    end
    Node
  end
end
