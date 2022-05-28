# Create with inspiration from https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/ripgrep.rb and https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/bat.rb
# https://github.com/dawidd6/homebrew-tap/blob/master/Formula/gothanks.rb
# Thanks a lot
# https://brew.sh/2020/11/18/homebrew-tap-with-bottles-uploaded-to-github-releases/
class Artem < Formula
  desc "Is a small cli program written in rust to easily convert images to ascii art"
  homepage "https://github.com/FineFindus/artem"
  url "https://github.com/FineFindus/artem/archive/refs/tags/v1.1.2.tar.gz"
  sha256 "af2c764cf383aea101fadc45bc1bcad4979de1c464a0c30156534bbacb26f917"
  license "MPL-2.0"

  bottle do
    root_url "https://github.com/FineFindus/homebrew-tap/releases/download/artem-1.0.3"
    sha256 cellar: :any_skip_relocation, big_sur:      "e657cc63076179fba9a8cf92c5240bdf7416d415d16e035260aee3083d6a7d39"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "890c30d81daf47bb107ce3987b5af57881284dd4f80991d79ce9b6ffd8b16f79"
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
    assert_match "Written 35 bytes to test.ans\n",
    shell_output("#{bin}/artem #{test_fixtures("test.png")} -o test.ans")
  end
end
