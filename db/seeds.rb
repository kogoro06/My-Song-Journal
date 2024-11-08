# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Emotion.create([
  { name: "喜び", image_path: "happy.png" },
  { name: "怒り", image_path: "angry.png" },
  { name: "哀しみ", image_path: "sad.png" },
  { name: "楽しさ", image_path: "fun.png" },
  { name: "中立", image_path: "neutral.png" },
  { name: "混乱", image_path: "confusion.png" }
])
