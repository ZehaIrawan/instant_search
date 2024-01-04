class SearchController < ApplicationController
  def search
    query = params[:query].presence
    if query.present?
      @results = Article.where("LOWER(title) LIKE ?", "%#{query.downcase}%")
      print("@results: #{@results}")
    else
      @results = []
    end
  end
end
