class SearchLogWorker
  include Sidekiq::Worker

  def perform(query, user_ip)
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
