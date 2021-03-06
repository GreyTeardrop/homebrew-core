class TomeePlume < Formula
  desc "Apache TomEE Plume"
  homepage "https://tomee.apache.org/"
  url "https://www.apache.org/dyn/closer.lua?path=tomee/tomee-8.0.4/apache-tomee-8.0.4-plume.tar.gz"
  mirror "https://archive.apache.org/dist/tomee/tomee-8.0.4/apache-tomee-8.0.4-plume.tar.gz"
  sha256 "fff4d98606f023b11c37bb7b4ceb74600552ff2953dc90fb484456236da34663"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "c95a98b18cab3b17572987e3c9c644519f7603118c073c4e0d68efe7f08398cf"
  end

  depends_on "openjdk"

  def install
    # Remove Windows scripts
    rm_rf Dir["bin/*.bat"]
    rm_rf Dir["bin/*.bat.original"]
    rm_rf Dir["bin/*.exe"]

    # Install files
    prefix.install %w[NOTICE LICENSE RELEASE-NOTES RUNNING.txt]
    libexec.install Dir["*"]
    (bin/"tomee-plume-startup").write_env_script "#{libexec}/bin/startup.sh",
                                                 Language::Java.overridable_java_home_env
  end

  def caveats
    <<~EOS
      The home of Apache TomEE Plume is:
        #{opt_libexec}
      To run Apache TomEE:
        #{opt_libexec}/bin/tomee-plume-startup
    EOS
  end

  test do
    ENV["JAVA_HOME"] = Formula["openjdk"].opt_prefix
    system "#{opt_libexec}/bin/configtest.sh"
  end
end
