# app/controllers/journals_controller.rb
class JournalsController < ApplicationController
  before_action :set_user

  def new
    @journal = Journal.new
  end

def create
  @journal = current_user.journals.build(journal_params) # current_userを使って関連付け
  if @journal.save
    # 作成後に「詳細設定」ページにリダイレクト
    redirect_to edit_journal_path(@journal), notice: "日記が作成されました。詳細設定を行ってください。"
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
      redirect_to journal_path(@journal), notice: "日記が更新されました。"
    else
      render :edit
    end
  end

  def index
    # @boardsを削除または必要な処理を追加
    # @boards = Board.includes(:user) # この行を削除
    @journals = Journal.includes(:user, :emotion).all # 日記の取得処理を追加
  end

  def show
  end

  def show
    @journal = Journal.find(params[:id])
    # もし日記が見つからなかった場合は、404エラーを返す
  rescue ActiveRecord::RecordNotFound
    redirect_to journals_path, alert: "日記が見つかりませんでした。"
  end

  def search_song
    song_name = params[:song]
    token = "YOUR_ACCESS_TOKEN" # ここに取得したアクセストークンを設定
  
    uri = URI("https://api.spotify.com/v1/search?q=#{URI.encode_www_form_component(song_name)}&type=track")
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{token}"
  
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
  
    songs = JSON.parse(response.body)["tracks"]["items"].map do |track|
      {
        id: track["id"],
        name: track["name"],
        artists: track["artists"].map { |artist| artist["name"] }
      }
    end
  
    render json: songs
  end
  

  def detail
    @journal = Journal.find(params[:id])
  end

  private

  def set_user
    @user = current_user # 現在のユーザーを取得
  end

  def journal_params
    params.require(:journal).permit(:title, :memo, :emotion_id, :custom_emotion, :song, :tags, :weather, :image, :goal, :quote, :public, :date, activity: [])
  end
end
