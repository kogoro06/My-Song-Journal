Devise.setup do |config|

  config.omniauth :spotify, ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"],
                  {
                    scope: "playlist-read-private user-read-private user-read-email user-modify-playback-state user-read-playback-state",
                    provider_ignores_state: true
                  }
end
