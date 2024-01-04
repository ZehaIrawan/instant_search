class SearchController < ApplicationController
  def search
    query = params[:query].presence
    if query.present?
      @results = Article.where("LOWER(title) LIKE ?", "%#{query.downcase}%")

       create_search_log(query)
    else
      @results = []
    end

    respond_to do |format|
      format.html # Render the HTML by default
      format.js   # Render JavaScript for AJAX requests
    end
  end

  private

  def create_search_log(query)
    print(request.remote_ip,"ip")
    user_ip = request.remote_ip
    SearchLog.create(query: query, ip_address: user_ip)
  end
end
