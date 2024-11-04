class JournalsController < ApplicationController
  def new
    @journal = Journal.new
    previous_journal = current_user.journals.order(date: :desc).first

    if previous_journal
      @journal.activity = previous_journal.goal.to_s.split("\n").map { |goal| { name: goal.strip, completed: false } }
    end
  end

  def create
    @journal = current_user.journals.build(journal_params)
    if @journal.save
      redirect_to @journal, notice: "日記が作成されました"
    else
      render :new
    end
  end

  def search_song
    song_name = params[:song]
    token = "BQC0Qns-kNahoCnaICF98AiRfv55KqRJi_i8HaVIpze6seJ43RBE9aPfkQ3C585Q2n0U9nqDY0Z-elTq4BAo2xv0aoEmzCDgtqpL162ivwNxfOOcqlA" # ここに取得したアクセストークンを設定

    uri = URI("https://api.spotify.com/v1/search?q=#{URI.encode_www_form_component(song_name)}&type=track")
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{token}"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    render json: JSON.parse(response.body)
  end

  private

  def journal_params
    params.require(:journal).permit(:title, :memo, :emotion_id, :custom_emotion, :song, :tags, :weather, :image, :goal, :quote, :public, :date, activity: [])
  end
end
