class ClaudePicker < Formula
  desc "Terminal session manager for Claude Code — browse, preview, and resume sessions with per-model cost tracking."
  homepage "https://github.com/anshul-garg27/claude-picker"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/anshul-garg27/claude-picker/releases/download/v0.5.0/claude-picker-aarch64-apple-darwin.tar.xz"
      sha256 "7dc6547038979f3d09c67571a9e9ccf62f4a8f2d0d2f3fc1a93487c0176d8784"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anshul-garg27/claude-picker/releases/download/v0.5.0/claude-picker-x86_64-apple-darwin.tar.xz"
      sha256 "cb5850ab2faad9d728b82f3030957015cf4f987c72fcb5972a25bf833d3bc369"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/anshul-garg27/claude-picker/releases/download/v0.5.0/claude-picker-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0b3874b81e4c8df2edc37c448942cafac9993edff8dfdfbdc26f20c73576172e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anshul-garg27/claude-picker/releases/download/v0.5.0/claude-picker-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e0455c33addda7b035f727763e712edb6f05e4f8d6cdf23e66629db0ceec2633"
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
