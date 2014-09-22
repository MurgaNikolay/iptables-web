class IndexController < ApplicationController
  skip_before_filter :check_authentication
  def index

  end
end
