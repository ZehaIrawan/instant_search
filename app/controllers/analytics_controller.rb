class AnalyticsController < ApplicationController
  def index
    @search_logs = SearchLog.all
  end
end
