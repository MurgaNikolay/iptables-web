class NodesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: Node.all
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
    node_params[:access_rules].each do |access_rule|
      if access_rule[:id]
        rule = node.access_rules.find(access_rule[:id])
        rule.update(access_rule)
        # rule.save
      else
        node.access_rules.build(access_rule)
      end
    end if node_params[:access_rules]

    if node.save
      head :no_content, status: 400
    else
      render json: {errors: 'error'}, status: 400
    end
  end

  def create
    node = Node.new
    if node.save
      redirect_to node_url(node)
    else
      render json: {errors: 'error'}, status: 400
    end
  end

  private
  def node_params
    params.require(:node).permit(:id, :hostname, :access_rules => [
        :id, :port, :ip, :protocol, :description
    ], :security_groups => [:name, :id]
    )
  end
end
