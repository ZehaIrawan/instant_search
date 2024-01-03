#Create articles with titles and content
articles = [
  { title: 'First Article', content: 'Content for the first article.' },
  { title: 'Second Article', content: 'Content for the second article.' },
  { title: 'Third Article', content: 'Content for the third article.' }
]

# Loop through the articles array and create Article records
articles.each do |article_data|
  Article.create(article_data)
end