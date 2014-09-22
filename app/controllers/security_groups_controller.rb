class SecurityGroupsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    puts params
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
      render json: SecurityGroup.all
    end
  end

  def show
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
    # redirect_to rule
    if group.save
       redirect_to access_rule_url(group)
    end
    # else
    #   This line overrides the default rendering behavior, which
    #   would have been to render the "create" view.
      # render json: {errors: 'error'}, status: 400
    # end


    # result = AccessRule.create_by_params(params.merge({user: current_user, request: request}))
    # if result.is_a?(Hash)
    #   render json: {errors: result}, status: 400
    # else
    #   render json: {ok: '1'}, status: 200
    # end
  end

  def update
    group = SecurityGroup.find(params[:id])
    return render :status => 404 unless group
    update_params[:access_rules].each do |access_rule|
      if access_rule[:id]
        rule = group.access_rules.find(access_rule[:id])
        rule.update(access_rule)
        # rule.save
      else
        group.access_rules.build(access_rule)
      end
    end if update_params[:access_rules]

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

  private
  def update_params
    params.require(:security_group).permit(:id, :hostname, :access_rules => [
        :id, :port, :ip, :protocol, :description
    ])
  end
end
