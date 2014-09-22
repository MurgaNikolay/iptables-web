class AccessRulesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: AccessRule.all
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
    rule = AccessRule.new(user_params)
    # redirect_to rule
    if rule.save
       redirect_to access_rule_url(rule)
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

  private
  def user_params
    params.require(:access_rule).permit(:protocol, :ip, :port, :description)
  end
end
