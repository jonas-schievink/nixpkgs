{ stdenv, fetchFromGitHub, cmake, git, swig, boost, udev, python37Packages }:

with python37Packages; buildPythonPackage rec {
  pname = "pc-ble-driver-py";
  version = "0.14.2";

  src = fetchFromGitHub {
    owner = "NordicSemiconductor";
    repo = "pc-ble-driver-py";
    rev = "v${version}";
    fetchSubmodules = true;
    sha256 = "1zbi3v4jmgq1a3ml34dq48y1hinw2008vwqn30l09r5vqvdgnj8m";
  };

  nativeBuildInputs = [ cmake swig git setuptools scikit-build ];
  buildInputs = [ boost udev ];
  propagatedBuildInputs = [ enum34 wrapt future ];

  dontUseCmakeConfigure = true;
  /*preBuild = ''
    pushd ../build
    cmake ..
    make -j $NIX_BUILD_CORES
    popd
  '';*/

  meta = with stdenv.lib; {
    description = "Bluetooth Low Energy nRF5 SoftDevice serialization";
    homepage = "https://github.com/NordicSemiconductor/pc-ble-driver-py";
    license = licenses.unfreeRedistributable;
    platforms = platforms.unix;
    maintainers = with maintainers; [ gebner ];
  };
}
