# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


ReflectionTip.create!([
  {
    category: "physical",
    keyword: "hungry",
    tip: "Try a balanced snack with protein and fiber to steady your energy. Your body is asking to be heard, not ignored."
  },
  {
    category: "intellectual",
    keyword: "loopy",
    tip: "Feeling loopy? You might be overstimulated or under-rested. Take 10 minutes to pause, breathe, or journal to clear the mental fog."
  },
  {
    category: "emotional",
    keyword: "sad",
    tip: "Sadness is not weakness — it’s wisdom. Reach out to someone who gets you, or revisit something that once brought you comfort."
  },
  {
    category: "spiritual",
    keyword: "disconnected",
    tip: "Feeling disconnected can be a signal to reconnect — to nature, a ritual, or a small moment of stillness. Choose something grounding today."
  }
])