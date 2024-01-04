class AnalyticsController < ApplicationController
  def index
    @SearchLog = SearchLog.all
  end
end
