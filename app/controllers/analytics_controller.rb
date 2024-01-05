class AnalyticsController < ApplicationController
  def index
    @search_logs = SearchLog.all
    @trends =   trends = SearchLog.select('query, COUNT(DISTINCT ip_address) AS user_count')
                     .group(:query)
                     .order('user_count DESC')
  end
end
