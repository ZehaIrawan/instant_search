class SearchController < ApplicationController
  def index
    @articles = Article.all
  end

  def search
    query = params[:query].presence
    if query.present?
      @results = Article.where("LOWER(title) LIKE ?", "%#{query.downcase}%")

      create_search_log_async(query)
    else
      @results = []
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def create_search_log_async(query)
    user_ip = request.headers['X-Forwarded-For'] || request.headers['X-Real-IP'] || request.remote_ip
    Rails.logger.info("User IP: #{user_ip}")
    SearchLogWorker.perform_async(query, user_ip)
  end
end
