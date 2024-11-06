# app/controllers/journals_controller.rb
class JournalsController < ApplicationController
  def new
    @journal = Journal.new
  end

  def create
    @journal = current_user.journals.build(journal_params)
    if @journal.save
      redirect_to detail_journal_path(@journal), notice: "日記が作成されました"
    else
      render :new
    end
  end

  def edit
    @journal = Journal.find(params[:id])
  end

  def update
    @journal = Journal.find(params[:id])
    if @journal.update(journal_params)
      redirect_to detail_journal_path(@journal), notice: "日記が更新されました"
    else
      render :edit
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

  def detail
    @journal = Journal.find(params[:id])
  end

  private

  def journal_params
    params.require(:journal).permit(:title, :memo, :emotion_id, :custom_emotion, :song, :tags, :weather, :image, :goal, :quote, :public, :date, activity: [])
  end
end
