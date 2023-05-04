class Forgit < Formula
  desc "Interactive git commands in the terminal"
  homepage "https://github.com/wfxr/forgit"
  url "https://github.com/wfxr/forgit/releases/download/23.05.0/forgit-23.05.0.tar.gz"
  sha256 "fe43076c7a22ac74951147e175130efbb578fdfc3901ecc45333b47dd6ef701b"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "dd4754e370b3a0aad8afdf03901f14e5263b893dc87fe6e1b31d008df2b03694"
  end

  depends_on "fzf"

  def install
    bin.install "bin/git-forgit"
    bash_completion.install "completions/git-forgit.bash"
    inreplace "forgit.plugin.zsh", 'FORGIT="$INSTALL_DIR', "FORGIT=\"#{opt_prefix}"
    pkgshare.install "forgit.plugin.zsh"
    pkgshare.install_symlink "forgit.plugin.zsh" => "forgit.plugin.sh"
  end

  def caveats
    <<~EOS
      A shell plugin has been installed to:
        #{opt_pkgshare}/forgit.plugin.zsh
        #{opt_pkgshare}/forgit.plugin.sh
    EOS
  end

  test do
    system "git", "init"
    (testpath/"foo").write "bar"
    system "git", "forgit", "add", "foo"
  end
end
