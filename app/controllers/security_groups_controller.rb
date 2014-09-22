class SecurityGroupsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if params[:term]
      query = SecurityGroup.where('name LIKE ?', "#{params[:term]}%")
      if params[:node]
        puts params[:node]
        begin
          node = Node.find(params[:node])
          query = query.where('id NOT IN (?)', node.security_groups.map(&:id).join(',')) if node.security_groups.size() > 0
        rescue

        end
      end
      render json: query.map(&:attributes)
    else
      render json: context.all
    end
  end

  def show
    puts '---------------------'
    puts SecurityGroup.find(params[:id]).access_rules.inspect
    render json: SecurityGroup.find(params[:id])
  end

  def destroy
    group = SecurityGroup.find(params[:id])
    respond_to do |format|
      if group.destroy
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: group.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    group = SecurityGroup.new(create_params)
    if group.save
       redirect_to security_group_url(group)
    end
  end

  def update
    group = SecurityGroup.find(params[:id])
    return render :status => 404 unless group
    access_rules.each do |access_rule|
      if access_rule[:id]
        rule = group.access_rules.find(access_rule[:id])
        rule.update(access_rule)
        # rule.save
      else
        group.access_rules.build(access_rule)
      end
    end if access_rules
    group.assign_attributes(update_params)
    if group.save
      head :no_content, status: 400
    else
      render json: {errors: 'error'}, status: 400
    end
  end

  private
  def create_params
    params.require(:security_group).permit(:name)
  end

  def access_rules
    access_rules = params.require(:security_group).permit(access_rules: [:id, :port, :ip, :protocol, :description])
    access_rules[:access_rules]
  end

  def update_params
    params.require(:security_group).permit(:id, :name)
  end

  def context
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return @context ||= $1.classify.constantize.find(value).security_groups
      end
    end
    Node
  end

end
