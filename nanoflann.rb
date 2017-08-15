class Nanoflann < Formula
  desc "C++ header-only library for Nearest Neighbor search wih KD-trees"
  homepage "https://jlblancoc.github.io/nanoflann/"
  url "https://github.com/jlblancoc/nanoflann/archive/v1.2.3.tar.gz"
  sha256 "5ef4dfb23872379fe9eb306aabd19c9df4cae852b72a923af01aea5e8d7a59c3"

  head "https://github.com/jlblancoc/nanoflann.git"

  depends_on "cmake" => :build

  def install
    # disable examples because there's no install mechanism
    inreplace "CMakeLists.txt", "add_subdirectory(examples)", ""

    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <nanoflann.hpp>
      int main() {
        nanoflann::KNNResultSet<size_t> resultSet(1);
        return 0;
      }
    EOS
    system ENV.cc, "test.cpp", "-o", "test"
    system "./test"
  end
end
