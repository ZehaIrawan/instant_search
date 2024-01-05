# Handling Pyramid problem

1. Delay Debounce
2. Check if previous query from the same IP is included in the current query

# Handling scaling with sidekiq
Without sidekiq the search method in controller with wait until the creation of SearchLog db entry, which will slow down the app.

With sidekiq we can put it in the background task and make it faster as it's using Redis as a job management store to process thousands of jobs per second.

## Bug
[x] Search doesn't work if navigate to analytics then come back
[] trends on what people are searching for the most.
[] seeds run everytime I deploy, need to delete first