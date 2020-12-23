class Mpg123 < Formula
  desc "MP3 player for Linux and UNIX"
  homepage "https://www.mpg123.de/"
  url "https://www.mpg123.de/download/mpg123-1.26.4.tar.bz2"
  mirror "https://downloads.sourceforge.net/project/mpg123/mpg123/1.26.4/mpg123-1.26.4.tar.bz2"
  sha256 "081991540df7a666b29049ad870f293cfa28863b36488ab4d58ceaa7b5846454"

  livecheck do
    url "https://www.mpg123.de/download/"
    regex(/href=.*?mpg123[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 "eaca212bd2fbd93cae9dff2142868c8ab2ba63c8f757657fa0f24a780f21b555" => :big_sur
    sha256 "95a40afc24b7ab30eff21a988421d9b172f5b073fe3291cf01db8b42531f5ca4" => :catalina
    sha256 "9b4f0e5aa8a80ff30ffa01c4076f76112d7252015416c5b58a7e5b4a5862d786" => :mojave
    sha256 "426a0e2c5650cd89be77a3aa78f8ebcb7bd5a2fd220675dc58c630be0ab0ec15" => :high_sierra
  end

  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --prefix=#{prefix}
      --with-default-audio=coreaudio
      --with-module-suffix=.so
      --with-cpu=x86-64
    ]
    system "./configure", *args
    system "make", "install"
  end

  test do
    system bin/"mpg123", "--test", test_fixtures("test.mp3")
  end
end
