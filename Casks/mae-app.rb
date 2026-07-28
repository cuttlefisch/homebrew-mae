cask "mae-app" do
  version "0.14.60"
  sha256 "43f9e5076dd9d251c6d8c8c371e6a790712503e26765b7569b639ae8cab581cd"

  url "https://github.com/cuttlefisch/mae/releases/download/v#{version}/MAE-macos-aarch64.zip"
  name "MAE - Modern AI Editor"
  desc "AI-native lisp machine editor with GUI"
  homepage "https://github.com/cuttlefisch/mae"

  depends_on formula: "cuttlefisch/mae/mae"
  depends_on :macos

  app "MAE.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/MAE.app"],
                   sudo: false
  rescue
    # Quarantine attribute may not exist
  end

  zap trash: [
    "~/Library/LaunchAgents/com.cuttlefisch.mae-daemon.plist",
    "~/Library/Logs/mae",
    "~/Library/Saved Application State/com.cuttlefisch.mae.savedState",
  ]
end
