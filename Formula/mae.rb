class Mae < Formula
  desc "AI-native lisp machine editor — successor to GNU Emacs"
  homepage "https://github.com/cuttlefisch/mae"
  version "0.14.155"
  license "GPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/cuttlefisch/mae/releases/download/v#{version}/mae-macos-aarch64.tar.gz"
      sha256 "c042030d6ca1b2901e192014c62812a2a2d4afeb7cd2e241dfd4c77e92e674af"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cuttlefisch/mae/releases/download/v#{version}/mae-linux-x86_64.tar.gz"
      sha256 "42fd2b501a091bebd7651444b03306a1c53cf6dcc3d0fd84e55f7319683142ff"
    end
  end

  def install
    # Binaries
    bin.install "mae"
    bin.install "mae-mcp-shim"
    bin.install "mae-daemon"

    # Data files (read-only, versioned with formula)
    (share/"mae").install "mae-manual.cozo"
    (share/"mae").install "modules"

    # Config templates (etc persists across upgrades)
    (etc/"mae").install "sample-config.toml" => "config.toml.sample"
    (etc/"mae").install "daemon-config.toml" => "daemon.toml.sample"

    # SHA checksum for runtime validation
    (share/"mae").install "mae-manual.cozo.sha256" if File.exist?("mae-manual.cozo.sha256")
  end

  service do
    run [opt_bin/"mae-daemon"]
    keep_alive crashed: true
    log_path var/"log/mae/mae-daemon.log"
    error_log_path var/"log/mae/mae-daemon.log"
    environment_variables PATH: std_service_path_env
  end

  def caveats
    <<~EOS
      To start the background daemon:
        brew services start mae

      Config templates are in:
        #{etc}/mae/

      Create your config (first time only):
        mkdir -p ~/.config/mae
        cp #{etc}/mae/config.toml.sample ~/.config/mae/config.toml
        cp #{etc}/mae/daemon.toml.sample ~/.config/mae/daemon.toml

      Manual KB (860+ help nodes) installed to:
        #{share}/mae/mae-manual.cozo

      Get started:
        mae file.rs          # GUI mode
        mae -nw file.rs      # terminal mode
        :help                # built-in help
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mae --version")
    system "#{bin}/mae", "--check-config"
  end
end
