#Create articles with titles and content
articles = [
  { title: 'How to create your Coaching Frameworks', content: 'Content for the article.' },
  { title: 'Why Coaching Frameworks are important', content: 'Content for the article.' },
  { title: 'Aircall Voice Integration With Zinny', content: 'Content for the article.' },
  { title: 'Zoom Phone Voice Integration With Zinny', content: 'Content for the article.' },
  { title: 'Zinny Sidekick and Zoom', content: 'Content for the article.' },
  { title: 'Invite Zinny into your meetings', content: 'Content for the article.' },
  { title: 'How to set up your Coaching Framework in Zinny', content: 'Content for the article.' },
  { title: 'Configuring your Firewall', content: 'Content for the article.' },
  { title: 'Installing Zoom for Zinny', content: 'Content for the article.' },
  { title: 'Configuring the Activity Types', content: 'Content for the article.' },
]

# Loop through the articles array and create Article records
articles.each do |article_data|
  Article.create(article_data)
end