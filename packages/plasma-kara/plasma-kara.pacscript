pkgname="plasma-kara"
pkgdesc="KDE applet for the Plasma pager"
pkgver="1.0.0"
repology=("project: kara")
arch=("all")
breaks=("${pkgname}-git")
url='https://github.com/dhruv8sh/kara'
source=("https://github.com/dhruv8sh/kara/archive/refs/tags/v${pkgver}.tar.gz")
sha256sums=("9cd23ab8e03243f9891f2d01805bcf12a62258f95d4d2917498a5413ea023393")
license=("GPL-3.0-only")
maintainer=("Erik Hedlund <erikcghedlund@outlook.com>")
depends=("plasma-desktop>=4:6.0.0" "libkf6i18n6>=6.0.0" "libkf6service6>=6.0.0" "libkf6windowsystem6>=6.0.0" "libplasmaactivities6>=6.0.0 | libplasmaactivities7>=6.0.0" "libdrm2")
makedepends=("cmake" "build-essential" "qt6-declarative-dev>=6.4.0" "extra-cmake-modules" "qt6-base-dev>=6.4.0" "libkf6i18n-dev>=6.0.0" "libkf6service-dev>=6.0.0" "libkf6windowsystem-dev>=6.0.0" "plasma-workspace-dev" "libplasmaactivities-dev" "kwin-dev" "pkg-config" "libdrm-dev")

prepare() {
  mkdir "${srcdir}/kara-${pkgver}/build"
}

build() {
  cd "${srcdir}/kara-${pkgver}/build"
  cmake -DCMAKE_BUILD_TYPE=Release -DKDE_INSTALL_USE_QT_SYS_PATHS=OFF ..
  make -j"${NCPU}"
}

package() {
  cd source/
  make -C "${srcdir}/kara-${pkgver}/build" DESTDIR="${pkgdir}" install
}
