class EmotionsController < ApplicationController
  def image
    emotion = Emotion.find(params[:id])
    if emotion.image_path.present?
      image_file = view_context.image_path(emotion.image_path)
      render json: { image_path: image_file }
    else
      render json: { message: "画像がありません" }
    end
  end
end
