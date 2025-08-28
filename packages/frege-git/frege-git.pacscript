pkgname='frege-git'
pkgdesc='Frege is a Haskell for the JVM. It brings purely functional programing to the Java platform.'
gives="frege"
repology=("project: frege")
arch=("all")
breaks=("${gives}")
url='https://github.com/Frege/frege'
pkgver="3.25alpha"
source=(
  "https://github.com/Frege/${gives}.git"
  "fregec.jar::https://github.com/Frege/${gives}/releases/download/${pkgver}/${gives}3.25.84.jar" # Needed for the bootstrap
)
sha256sums=(
  "SKIP"
  "66c60007d5a3661ef8330ffc0c775d2099fcab35ee4b4087612b95a6ee181cf3"
)
depends=("openjdk-11-jre")
makedepends=("make" "openjdk-11-jdk" "time" "pbyacc | byacc-j")
license=("BSD-3-Clause")
maintainer=("Erik Hedlund <erikcghedlund@outlook.com>")

prepare() {
  mv "${srcdir}/fregec.jar" "${srcdir}/${gives}/fregec.jar"
  echo -e "package frege.Version where\n    version = \"${pkgver}-${git_pkgver}-pacstall\"\n    commit = \"${git_pkgver}\"" > "${srcdir}/${gives}/Version.fr"
  sed -i 's/fregec.jar: test/fregec.jar:/g' "${srcdir}/${gives}/Makefile" # We don't want to be forced to run the tests (for instance when passing -Nc)
}

build() {
  make -C "${srcdir}/${gives}" -j"${NCPU}" compiler
}

check() {
  make -C "${srcdir}/${gives}" -j"${NCPU}" test
}

package() {
  rm "${srcdir}/${gives}/fregec.jar"
  make -C "${srcdir}/${gives}" -j"${NCPU}" fregec.jar
  install -Dm644 "${srcdir}/${gives}/fregec.jar" "${pkgdir}/usr/share/java/fregec.jar"
  echo -e '#!/bin/sh\njava -jar /usr/share/java/fregec.jar $@' > "${srcdir}/fregec"
  install -Dm755 "${srcdir}/fregec" "${pkgdir}/usr/local/bin/fregec"
}
