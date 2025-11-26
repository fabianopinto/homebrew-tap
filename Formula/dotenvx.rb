class Dotenvx < Formula
  desc "A secure environment variable management tool with built-in encryption"
  homepage "https://github.com/fabianopinto/dotenvx"
  version "0.2.2"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/fabianopinto/dotenvx/releases/download/v0.2.2/dotenvx-aarch64-apple-darwin.tar.gz"
      sha256 ""
    else
      url "https://github.com/fabianopinto/dotenvx/releases/download/v0.2.2/dotenvx-x86_64-apple-darwin.tar.gz"
      sha256 ""
    end
  end

  def install
    bin.install "dotenvx"
  end

  test do
    system "#{bin}/dotenvx", "--version"
  end
end
