class StaticController < ApplicationController
  def index
    @transaction = Sermepa::Rails::Transaction.new
  end
end
