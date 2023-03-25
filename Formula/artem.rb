# Create with inspiration from https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/ripgrep.rb and https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/bat.rb
# https://github.com/dawidd6/homebrew-tap/blob/master/Formula/gothanks.rb
# Thanks a lot
# https://brew.sh/2020/11/18/homebrew-tap-with-bottles-uploaded-to-github-releases/
class Artem < Formula
  desc "Is a small cli program written in rust to easily convert images to ascii art"
  homepage "https://github.com/FineFindus/artem"
  url "https://github.com/FineFindus/artem/archive/refs/tags/v1.1.7.tar.gz"
  sha256 "56cb7e83d50b54be3d69971915a3a389a53a15abbdb119a48e0e43277ecb0563"
  license "MPL-2.0"

  bottle do
    root_url "https://github.com/FineFindus/homebrew-tap/releases/download/artem-1.1.5"
    sha256 cellar: :any_skip_relocation, big_sur:      "2230c09d02cfdafa2f14ab35c0f7401ea17cc0e76e731502d376f71f8b7b146b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a5b42ea17482d05ff304c4120351e8236f8b5b8c9b9c2ce010ad15f266683652"
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
