class Rsdirstat < Formula
  desc "Fast, cross-platform disk usage analyzer with a treemap GUI"
  homepage "https://github.com/rikshot/rsdirstat"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rikshot/rsdirstat/releases/download/v0.1.3/rsdirstat-aarch64-apple-darwin.tar.xz"
      sha256 "699ed0d26b40365e0700be2a846bf892b3ad8dd9da95f38d9a39d9e6b059abbf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rikshot/rsdirstat/releases/download/v0.1.3/rsdirstat-x86_64-apple-darwin.tar.xz"
      sha256 "96e49c8285de3265bc2fba467081d0a8a0ee020d5e038b698d3040a403ca43ec"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rikshot/rsdirstat/releases/download/v0.1.3/rsdirstat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "690e3a32b1c9a4e81a1914e1a7319bf142404fddf467bdb0423f8bb7f327d19f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rikshot/rsdirstat/releases/download/v0.1.3/rsdirstat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f9d651bd84b5d69240d2dd02f864d187958c95307e4ba6fa8220e0acc1e77f46"
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
