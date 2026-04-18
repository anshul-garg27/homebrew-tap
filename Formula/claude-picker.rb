class ClaudePicker < Formula
  desc "Terminal session manager for Claude Code — browse, preview, and resume sessions with per-model cost tracking."
  homepage "https://github.com/anshul-garg27/claude-picker"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/anshul-garg27/claude-picker/releases/download/v0.3.0/claude-picker-aarch64-apple-darwin.tar.xz"
      sha256 "ff54e614a6e687f87ce7622415800653f6bd0f64f288b8aae18e806bc7c5e4e3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anshul-garg27/claude-picker/releases/download/v0.3.0/claude-picker-x86_64-apple-darwin.tar.xz"
      sha256 "b4fa6ae7ae2eda8fb353a80313380a75b1ce885dba552bbb2776c0ecd39cae59"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/anshul-garg27/claude-picker/releases/download/v0.3.0/claude-picker-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f3f2ce5544eb106ae6611b3aa09bd14891af15d9a15eee4e46fbd0279b1dfc17"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anshul-garg27/claude-picker/releases/download/v0.3.0/claude-picker-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8aba9f9cd6a007dfb5aa546aaaefb46e55abb3bd4faaa1cb7ead502e87036487"
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
