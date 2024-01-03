require "test_helper"

class ArticleTest < ActiveSupport::TestCase
 test "should not save article without title" do
    article = Article.new
    assert_not article.save, "Saved the article without a title"
  end

  test "should save article with valid attributes" do
    article = Article.new(title: "Sample Title", content: "Sample Content")
    assert article.save, "Could not save the article with valid attributes"
  end
end
