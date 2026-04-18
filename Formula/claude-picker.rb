class ClaudePicker < Formula
  desc "Terminal session manager for Claude Code — browse, preview, and resume sessions with per-model cost tracking."
  homepage "https://github.com/anshul-garg27/claude-picker"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/anshul-garg27/claude-picker/releases/download/v0.4.0/claude-picker-aarch64-apple-darwin.tar.xz"
      sha256 "b08c9128ec6f61857006d01b6d6da954b673af9bfc1db536b2afe8d61f852bb6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anshul-garg27/claude-picker/releases/download/v0.4.0/claude-picker-x86_64-apple-darwin.tar.xz"
      sha256 "93f094723de67934a988daf142dbc0b8f613a7f93d64d275a0e4c35babca390d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/anshul-garg27/claude-picker/releases/download/v0.4.0/claude-picker-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8598dfbff77eb266665ff1308a9959969c04d1c7caf8ed0f7ce90b2b2cc59095"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anshul-garg27/claude-picker/releases/download/v0.4.0/claude-picker-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e7eb1135b63169705ed9db3a0a9ac309af7adc90ea846dddade458f68030a8b6"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "claude-picker" if OS.mac? && Hardware::CPU.arm?
    bin.install "claude-picker" if OS.mac? && Hardware::CPU.intel?
    bin.install "claude-picker" if OS.linux? && Hardware::CPU.arm?
    bin.install "claude-picker" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
