_pkgname='bstring'
pkgname="lib${_pkgname}"
pkgver='1.0.3'
pkgdesc='Better String Library'
url='https://mike.steinert.ca/bstring'
license=('BSD-3-Clause')
arch=('any')
source=("https://github.com/msteinert/${_pkgname}/archive/refs/tags/v${pkgver}.tar.gz")
makedepends=('meson' 'ninja-build' 'doxygen' 'pkg-config')
checkdepends=('check')
maintainer=('Erik Hedlund <erikcghedlund@outlook.com')
sha256sums=('a8b1613d4104e4c7e46bdedb123f0497d9a80ce3b34bdac3191a480e28556799')

prepare() {
  cd "${srcdir}/${_pkgname}-${pkgver}"
  if type "checkmk"; then
    meson setup build -Denable-docs=true --buildtype=release -Denable-tests=true --prefix='/usr'
  else
    meson setup build -Denable-docs=true --buildtype=release --prefix='/usr'
  fi
}

build() {
  meson compile -C "${srcdir}/${_pkgname}-${pkgver}/build"
}

check() {
  meson test -C "${srcdir}/${_pkgname}-${pkgver}/build"
}

package() {
  meson install -C "${srcdir}/${_pkgname}-${pkgver}/build" --destdir="${pkgdir}"
}
