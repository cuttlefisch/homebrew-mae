cask "mae-app" do
  version "0.14.131"
  sha256 "9e3ffe3e792bf0a1139f3e37670836c874b278719b808046162d98abe7fa72b6"

  url "https://github.com/cuttlefisch/mae/releases/download/v#{version}/MAE-macos-aarch64.zip"
  name "MAE - Modern AI Editor"
  desc "AI-native lisp machine editor with GUI"
  homepage "https://github.com/cuttlefisch/mae"

  depends_on formula: "cuttlefisch/mae/mae"
  depends_on :macos

  app "MAE.app"

  zap trash: [
    "~/Library/LaunchAgents/com.cuttlefisch.mae-daemon.plist",
    "~/Library/Logs/mae",
    "~/Library/Saved Application State/com.cuttlefisch.mae.savedState",
  ]

  caveats <<~EOS
    MAE.app is not notarized. If macOS refuses to open it, reinstall with:
      brew reinstall --cask --no-quarantine cuttlefisch/mae/mae-app
  EOS
end
