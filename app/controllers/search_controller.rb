class SearchController < ApplicationController
  def index
    @articles = Article.all
  end

  def search
    query = params[:query].presence
    if query.present?
      @results = Article.where("LOWER(title) LIKE ?", "%#{query.downcase}%")

       create_search_log(query)
    else
      @results = []
    end

    respond_to do |format|
      # format.html # Render the HTML by default
      format.js   # Render JavaScript for AJAX requests
    end
  end

  private

  def create_search_log(query)
  user_ip = request.remote_ip
  previous_query = SearchLog.where(ip_address: user_ip).order(created_at: :desc).pluck(:query).first

  if previous_query.present?
    if query.downcase.include?(previous_query.downcase)
      summarized_query = query
    else
      summarized_query = "#{previous_query}, #{query}"
    end
  else
    summarized_query = query
  end

  SearchLog.create(query: summarized_query, ip_address: user_ip)
  end
end
