{ stdenv, fetchFromGitHub, libxml2, libseccomp, curl }:

stdenv.mkDerivation rec {
  name = "rdrview";

  src = fetchFromGitHub {
    owner = "eafer";
    repo = name;
    rev = "9bde19f9e53562790b363bb2e3b15707c8c67676";
    sha256 = "1w6gam1gqyxwyyvr7b7bghxwdx27min849ksjz4p4q4bdglmi8p3";
  };

  makeFlags = [ "PREFIX=$(out)" ];

  buildInputs = [ libxml2 curl ]
    ++ (if stdenv.system == "x86_64-linux" then [ libseccomp ] else [ ]);
}
