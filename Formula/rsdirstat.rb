class Rsdirstat < Formula
  desc "Fast, cross-platform disk usage analyzer with a treemap GUI"
  homepage "https://github.com/rikshot/rsdirstat"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rikshot/rsdirstat/releases/download/v0.2.0/rsdirstat-aarch64-apple-darwin.tar.xz"
      sha256 "2cb34324c8ecbe79a411f28dec8b26cab4d8320f4be3cec2da320f23273b0947"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rikshot/rsdirstat/releases/download/v0.2.0/rsdirstat-x86_64-apple-darwin.tar.xz"
      sha256 "30b46a61b2918d7c5a0d5b2c728cfcf8d146249cfca1379c5a82b250081241e0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rikshot/rsdirstat/releases/download/v0.2.0/rsdirstat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8bdf5115953dfdde422a8a831fbe8ee4d8cb9189195e5e08aeb4d974da8fb026"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rikshot/rsdirstat/releases/download/v0.2.0/rsdirstat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bafe979180e68fc56e89ef5c71fee0bb715e6b342c9bf62b2af2c6460e61f43b"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "rsdirstat", "rsdirstat-cli"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "rsdirstat", "rsdirstat-cli"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "rsdirstat", "rsdirstat-cli"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "rsdirstat", "rsdirstat-cli"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
