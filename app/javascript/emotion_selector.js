document.addEventListener("DOMContentLoaded", function() {
    const emotionButtons = document.querySelectorAll('.emotion-button label');
    const emotionImage = document.getElementById("emotion_image");
  
    emotionButtons.forEach(label => {
      label.addEventListener("click", function() {
        const selectedImage = this.querySelector("img").src; // クリックした画像のパスを取得
        emotionImage.src = selectedImage; // 画像のソースを更新
      });
    });
  
    // 初期選択された感情があれば、その画像を表示
    const selectedEmotionId = document.querySelector('input[name="emotion_id"]:checked');
    if (selectedEmotionId) {
      const initialImage = document.querySelector(`label[for="${selectedEmotionId.id}"] img`).src;
      emotionImage.src = initialImage; // 初期選択された画像を表示
    }
  });
  