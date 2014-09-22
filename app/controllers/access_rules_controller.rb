class AccessRulesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: find_access_rulable.access_rules
  end

  def show
    render json: AccessRule.find(params[:id])
  end

  def destroy
    rule = AccessRule.find(params[:id])
    respond_to do |format|
      if rule.destroy
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: rule.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    access_rule = params[:id] ? AccessRule.find(params[:id]) : AccessRule.new
    access_rule.assign_attributes(access_rule_params)

    respond_to do |format|
      if access_rule.save
        format.html { redirect_to access_rule, notice: 'Comment was successfully created.' }
        format.json { render json: access_rule, status: :created, location: access_rule }
      else
        format.html { render action: 'new' }
        format.json { render json: {errors: access_rule.errors.messages}, status: :unprocessable_entity }
      end
    end
  end

  alias_method :update, :create

  private
  def access_rule_params
    params.require(:access_rule).permit(:protocol, :ip, :port, :description, :node_id, :security_group_id, :access_rulable_id, :access_rulable_type)
  end

  def parent
    if params[:node_id]
      return Node.find(params[:node_id])
    end

    if params[:security_group]
      return SecurityGroup.find(params[:security_group])
    end
  end


  def find_access_rulable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
