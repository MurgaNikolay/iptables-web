module Api
  class AccessRulesController < Api::BaseController
    def index
      full_access_rules = current_node.full_access_rules
      response.headers['Etag'] = Digest::MD5.hexdigest(full_access_rules.to_json)
      render json: full_access_rules, each_serializer: Api::AccessRuleSerializer
    end
  end
end
