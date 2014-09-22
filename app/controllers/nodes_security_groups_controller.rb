class NodesSecurityGroupsController < ApplicationController
  skip_before_action :verify_authenticity_token
  # respond_to :json
  def index
    if params[:node_id]
      render json: NodesSecurityGroup.where(node_id: params[:node_id], security_group_id: params[:security_group_id])
    else
      render json: NodesSecurityGroup.all
    end
  end

  def destroy
    link = NodesSecurityGroup.find(params[:id])
    respond_to do |format|
      if link.destroy
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: link.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    render json: NodesSecurityGroup.find(params[:id])
  end

  def update

  end

  def create
    link = NodesSecurityGroup.create(create_params)
    if link.save
      redirect_to nodes_security_group_url(link)
    else
      render json: {errors: 'error'}, status: 400
    end
  end

  private
  def create_params
    params.require(:nodes_security_group).permit(:node_id, :security_group_id)
  end
end
