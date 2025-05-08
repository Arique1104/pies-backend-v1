# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


[
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
].each do |attrs|
  ReflectionTip.find_or_create_by!(tip: attrs[:tip]) do |record|
    record.keyword = attrs[:keyword]
    record.category = attrs[:category]
  end
end


unmatched_keywords = [
  { word: "hydration", category: "physical", count: 12, example: "I need to drink more water" },
  { word: "focus", category: "intellectual", count: 8, example: "Hard to focus on my reading today" },
  { word: "isolation", category: "emotional", count: 5, example: "I’ve been feeling isolated lately" },
  { word: "purpose", category: "spiritual", count: 9, example: "Trying to find my purpose" },
  { word: "exercise", category: "physical", count: 14, example: "Didn’t get a chance to exercise" },
  { word: "overthinking", category: "intellectual", count: 6, example: "My brain won’t shut off" },
  { word: "grief", category: "emotional", count: 7, example: "Still dealing with grief" },
  { word: "gratitude", category: "spiritual", count: 10, example: "Feeling deep gratitude today" },
  { word: "fatigue", category: "physical", count: 11, example: "I’ve been so tired lately" },
  { word: "curiosity", category: "intellectual", count: 4, example: "I’m feeling curious about new things" }
]

unmatched_keywords.each do |kw|
  UnmatchedKeyword.find_or_create_by!(word: kw[:word], category: kw[:category]) do |record|
    record.count = kw[:count]
    record.example = kw[:example]
  end
end


[
  { word: "meh", category: "emotional", example: "I feel meh, like nothing really matters today." },
  { word: "tiredish", category: "physical", example: "Not exhausted, but definitely tiredish after that walk." },
  { word: "foggy", category: "intellectual", example: "My brain's just... foggy this morning." },
  { word: "unmoved", category: "spiritual", example: "Everyone else was inspired, but I felt unmoved." },
  { word: "overit", category: "emotional", example: "Honestly? I'm just over it." },
  { word: "zonedout", category: "intellectual", example: "I totally zoned out during the meeting." },
  { word: "hungrish", category: "physical", example: "Not starving, just kind of hungrish." },
  { word: "apathetic", category: "emotional", example: "I know I should care, but I feel apathetic." },
  { word: "whatever", category: "emotional", example: "My only response right now is whatever." },
  { word: "mehagain", category: "emotional", example: "It’s that same meh feeling again today." }
].each do |attrs|
  DismissedKeyword.find_or_create_by!(word: attrs[:word], category: attrs[:category]) do |dk|
    dk.example = attrs[:example]
  end
end
