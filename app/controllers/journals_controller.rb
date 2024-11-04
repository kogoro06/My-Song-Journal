class JournalsController < ApplicationController
  def new
    @journal = Journal.new
    @emotions = Emotion.all # 感情カテゴリのリストを取得
  end

  def create
    @journal = current_user.journals.build(diary_params)
    if @journal.save
      redirect_to @journal, notice: "日記が作成されました"
    else
      @emotions = Emotion.all
      render :new
    end
  end

  private

  def journal_params
    params.require(:diary).permit(:title, :body, :emotion_id, :song, :memo, :public)
  end
end
