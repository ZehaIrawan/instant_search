import { Controller } from "@hotwired/stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["query", "results"];

  connect() {
    console.log("Hello world", this.queryTarget);
  }

  input() {
    const query = this.queryTarget.value;

    console.log(query, "query");

    // Clear the previous debounce timer
    clearTimeout(this.debounceTimer);

    // Set a new debounce timer
    this.debounceTimer = setTimeout(() => {
      // Make an AJAX call using Rails.ajax
      Rails.ajax({
        type: "GET",
        url: "/search",
        data: `query=${encodeURIComponent(query)}`,
        dataType: "json",
        success: (data) => {
          console.log("AJAX response:", data);

          // Update the search results on the page
          this.resultsTarget.innerHTML = this.renderResults(data);
        },
        error: (error) => {
          console.error("AJAX error:", error);
        },
      });
    }, 500);
  }

  renderResults(results) {
    return results
      .map((result) => {
        return `
        <h2>${result.title}</h2>
        <p>${result.content}</p>
      `;
      })
      .join("");
  }
}
