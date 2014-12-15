module Api
  class AccessRulesController < Api::BaseController
    def index
      render json: current_node.full_access_rules, each_serializer: Api::AccessRuleSerializer
    end

    def show
      puts params
    end
  end
end
