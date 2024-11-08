class JournalsController < ApplicationController
  before_action :set_user
  before_action :set_journal, only: [ :edit, :update, :show ]

  def new
    @journal = Journal.new
  end

  def create
    @journal = current_user.journals.build(journal_params)
    if @journal.save
      redirect_to edit_journal_path(@journal), notice: "日記が作成されました。詳細設定を行ってください。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @journal.update(journal_params)
      redirect_to journal_path(@journal), notice: "日記が更新されました。"
    else
      render :edit
    end
  end

  def index
    @journals = Journal.includes(:user, :emotion).all
  end

  def show
    # 404エラーの処理はset_journalで行います
  end

  def search_song
    song_name = params[:song]
    token = "YOUR_ACCESS_TOKEN" # トークンの取得処理は外部で管理するのがベスト
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
    @user = current_user
  end

  def set_journal
    @journal = Journal.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to journals_path, alert: "日記が見つかりませんでした。"
  end

  def journal_params
    params.require(:journal).permit(:title, :memo, :emotion_id, :custom_emotion, :song, :tags, :weather, :image, :goal, :quote, :public, :date, activity: [])
  end
end
