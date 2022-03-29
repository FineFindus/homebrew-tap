# Create with inspiration from https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/ripgrep.rb and https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/bat.rb
# https://github.com/dawidd6/homebrew-tap/blob/master/Formula/gothanks.rb
# Thanks a lot
# https://brew.sh/2020/11/18/homebrew-tap-with-bottles-uploaded-to-github-releases/
class Artem < Formula
  desc "Is a small cli program written in rust to easily convert images to ascii art"
  homepage "https://github.com/FineFindus/artem"
  url "https://github.com/FineFindus/artem/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "5a961e2afd3d0546add6edd2c542fa8e5752537da75b1a1cc0d3cace9b217d1e"
  license "MPL-2.0"
  
  bottle do
    root_url "https://github.com/finefindus/homebrew-tap/releases/download/artem-0.6.1"
    sha256 cellar: :any_skip_relocation, big_sur:     "6f44c0778e2dd4b40425aafc70918455edee4b0c9d7a4aaad7ed54dc2dc6ed58"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c6bf9495ee9a79d77599002e1a58d1c2c7bf60f3a80dbaf32690c76e6c7d1449"
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
    assert_match "artem 0.6.0\n", shell_output("#{bin}/artem -V")
  end
end
