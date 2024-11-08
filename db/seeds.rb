# db/seeds.rb

# このファイルは、アプリケーションを実行するために必要なレコードを
# すべての環境（production、development、test）で作成することを目的としています。
# コードは冪等である必要があり、いつでも実行できるようにする必要があります。
# データは、bin/rails db:seedコマンドで読み込むことができます。

# Emotionモデルのレコードを作成
emotions = [
  { name: "喜び", image_path: "happy.png" },
  { name: "怒り", image_path: "angry.png" },
  { name: "哀しみ", image_path: "sad.png" },
  { name: "楽しさ", image_path: "fun.png" },
  { name: "中立", image_path: "neutral.png" },
  { name: "混乱", image_path: "confusion.png" }
]

# 既存のレコードを確認し、存在しない場合は作成する
emotions.each do |emotion|
  Emotion.find_or_create_by(name: emotion[:name]) do |e|
    e.image_path = emotion[:image_path]
  end
end
