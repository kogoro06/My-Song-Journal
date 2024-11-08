document.addEventListener("DOMContentLoaded", () => {
    const emotionSelect = document.getElementById("emotion_select");
    const emotionDisplay = document.getElementById("emotion-display");
  
    if (emotionSelect) {
      emotionSelect.addEventListener("change", () => {
        const emotionId = emotionSelect.value;
        if (emotionId) {
          fetch(`/emotions/${emotionId}/image`)
            .then(response => response.json())
            .then(data => {
              if (data.image_path) {
                emotionDisplay.innerHTML = `<img src="${data.image_path}" alt="Emotion Image" style="max-width: 100px; max-height: 100px;">`;
              } else {
                emotionDisplay.innerHTML = data.message || "画像の読み込みに失敗しました";
              }
            });
        } else {
          emotionDisplay.innerHTML = ""; // 選択がクリアされた場合は表示をリセット
        }
      });
    }
  });
  