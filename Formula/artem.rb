# Create with inspiration from https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/ripgrep.rb and https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/bat.rb
# Thanks a lot
class Artem < Formula
  desc "Is a small cli program written in rust to easily convert images to ascii art"
  homepage "https://github.com/FineFindus/artem"
  url "https://github.com/FineFindus/artem/archive/refs/tags/v#{version}.tar.gz"
  version "0.6.1"
  sha256 "5a961e2afd3d0546add6edd2c542fa8e5752537da75b1a1cc0d3cace9b217d1e"
  license "MPL-2.0"

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
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test artem`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    img = test_fixtures("test.png")
    output = shell_output("#{bin}/artem #{img} --no-color")
    assert_match "



      ", output
  end
end
