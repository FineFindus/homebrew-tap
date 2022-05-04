# Create with inspiration from https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/ripgrep.rb and https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/bat.rb
# https://github.com/dawidd6/homebrew-tap/blob/master/Formula/gothanks.rb
# Thanks a lot
# https://brew.sh/2020/11/18/homebrew-tap-with-bottles-uploaded-to-github-releases/
class Artem < Formula
  desc "Is a small cli program written in rust to easily convert images to ascii art"
  homepage "https://github.com/FineFindus/artem"
  url "https://github.com/FineFindus/artem/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "3582a8065c2d5e1e54906a0fe6b030bcb289cb9261221b9bf40311731f8db5e7"
  license "MPL-2.0"

  bottle do
    root_url "https://github.com/FineFindus/homebrew-tap/releases/download/artem-0.6.1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, big_sur:      "8a5363ca9a960ca8a4c00f1e84c9112a1632023ee80ed8b793ede7bf77ea843d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dc058a30237cd868ae3234624eade248166d583e326817eac9ca1bff41c2601b"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    # Completion scripts and manpage are generated in the crate's build
    # directory, which includes a fingerprint hash. Try to locate it first
    out_dir = Dir["target/release/build/artem-*/out"].first
    man1.install "#{out_dir}/artem.1"
    bash_completion.install "#{out_dir}/artem.bash"
    fish_completion.install "#{out_dir}/artem.fish"
    zsh_completion.install "#{out_dir}/_artem"
  end

  test do
    system bin/"artem", test_fixtures("test.png"), "-o output.txt"
    assert_predicate "output.txt", :exist?
  end
end
