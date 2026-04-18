class ClaudePicker < Formula
  desc "Terminal session manager for Claude Code — browse, preview, and resume sessions with per-model cost tracking."
  homepage "https://github.com/anshul-garg27/claude-picker"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/anshul-garg27/claude-picker/releases/download/v0.4.1/claude-picker-aarch64-apple-darwin.tar.xz"
      sha256 "9330a6181884ce61066e620cb3262d8f6fc07b23b8f804d0ec44f45c5c808356"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anshul-garg27/claude-picker/releases/download/v0.4.1/claude-picker-x86_64-apple-darwin.tar.xz"
      sha256 "c69d7b0cad33706671e89c2569e0133fa47f34fa29de0a40ed3ab753e7b6ec0f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/anshul-garg27/claude-picker/releases/download/v0.4.1/claude-picker-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "db520e202bb0656f9ca78bd2cf5bc5910b506a5615be602793e2a354a17e75d9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anshul-garg27/claude-picker/releases/download/v0.4.1/claude-picker-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "44de0f0ef3e9dd2a04ce513d493cd7ac1a046f77e87ef68af82b5549f6117159"
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
