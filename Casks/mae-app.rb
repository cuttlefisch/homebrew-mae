cask "mae-app" do
  version "0.14.178"
  sha256 "cb886263729f3b60e315c038f2f1241f88cbdfb9a845a908bf3a8a0ecbe817fc"

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
