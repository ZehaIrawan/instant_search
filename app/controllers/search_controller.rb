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


    # respond_to do |format|
    #   format.json
    # end
    respond_to do |format|
      format.json { render json: @results } # Explicitly render JSON response
    end
  end

 private

def create_search_log_async(query)
  user_ips = request.headers['X-Forwarded-For']
  user_ip = user_ips ? user_ips.split(',').map(&:strip).first : request.remote_ip

  # Use Sidekiq to create the SearchLog asynchronously in development
  if Rails.env.development?
    SearchLogWorker.perform_async(query, user_ip)
  end

  if Rails.env.production?
    previous_query = SearchLog.where(ip_address: user_ip).order(created_at: :desc).pluck(:query).first

    if previous_query.present? && query.downcase.include?(previous_query.downcase)
      SearchLog.where(ip_address: user_ip, query: previous_query).delete_all
      summarized_query = query
    else
      summarized_query = query
    end

    # Create the SearchLog asynchronously
    SearchLog.create(query: summarized_query, ip_address: user_ip)
  end
end
end
