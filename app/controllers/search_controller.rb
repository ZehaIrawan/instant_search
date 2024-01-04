class SearchController < ApplicationController
  def search
    query = params[:query].presence
    if query.present?
      @results = Article.where("LOWER(title) LIKE ?", "%#{query.downcase}%")
    else
      @results = []
    end

    respond_to do |format|
      format.html # Render the HTML by default
      format.js   # Render JavaScript for AJAX requests
    end
  end
end
