class ClaudePicker < Formula
  desc "Terminal session manager for Claude Code — browse, preview, and resume sessions with per-model cost tracking."
  homepage "https://github.com/anshul-garg27/claude-picker"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/anshul-garg27/claude-picker/releases/download/v0.2.2/claude-picker-aarch64-apple-darwin.tar.xz"
      sha256 "ff7331812af8ed240b9edac777f9ea8c60a896399ddebad0c73898256740905d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anshul-garg27/claude-picker/releases/download/v0.2.2/claude-picker-x86_64-apple-darwin.tar.xz"
      sha256 "87a80320c3efaae43764e346b4542cce24e3d5b181d78dfde1962c9df6b72bb6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/anshul-garg27/claude-picker/releases/download/v0.2.2/claude-picker-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "aa5413b4a77ba4abd4825bdd7263b2ea5a8dd6898bc7ed207e9b51b8b04c5674"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anshul-garg27/claude-picker/releases/download/v0.2.2/claude-picker-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "106ba8392f29f384ed785864f09e13c5f2455abb6336733aa7f9cc746a388a17"
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
