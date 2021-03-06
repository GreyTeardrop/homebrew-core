class Jansson < Formula
  desc "C library for encoding, decoding, and manipulating JSON"
  homepage "https://digip.org/jansson/"
  url "https://digip.org/jansson/releases/jansson-2.13.1.tar.gz"
  sha256 "f4f377da17b10201a60c1108613e78ee15df6b12016b116b6de42209f47a474f"
  license "MIT"

  livecheck do
    url "https://digip.org/jansson/releases/"
    regex(/href=.*?jansson[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "8e2f0225f8aa78bf75a1c61c8ee85e7dbd0292ca0aa9f186c9da960cdeb2b85a"
    sha256 cellar: :any,                 big_sur:       "7f9717b979d7d66db054be03cfebb72e088e413b5d6125c7cd735db064897671"
    sha256 cellar: :any,                 catalina:      "e6a942f77821fd65810d4bc20e6938364a5e40cd7c8510c4b090731573bd0088"
    sha256 cellar: :any,                 mojave:        "587acdadd1ea8bcf22c316f55a32084f530280a7e24f0864e0e420718d0d1b7f"
    sha256 cellar: :any,                 high_sierra:   "38085c147eb40d58df8a91a44e7544d4ceb248aa25f54bdd8a3b10c1a214d9e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "68f0ccce7120f3a62dec4886fa286cab0bda3a126608f707cf1732662442c1a0"
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <jansson.h>
      #include <assert.h>

      int main()
      {
        json_t *json;
        json_error_t error;
        json = json_loads("\\"foo\\"", JSON_DECODE_ANY, &error);
        assert(json && json_is_string(json));
        json_decref(json);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-ljansson", "-o", "test"
    system "./test"
  end
end
