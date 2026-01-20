pkgname='metapac'
pkgver='0.8.0'
pkgdesc='Multi-backend declarative package manager'
license=('GPL-3.0-only')
repology=("project: ${pkgname}")
url='https://github.com/ripytide/metapac'
arch=('any')
maintainer=("Erik Hedlund <erikcghedlund@outlook.com>")
source=("https://github.com/ripytide/${pkgname}/archive/refs/tags/v${pkgver}.tar.gz")
sha256sums=('ce1c2dd574889c60db243e2bbc295e62f763ff46a360f790e783542ce060a965')
_min_cargo='1.85'
makedepends=("cargo>=${_min_cargo} | cargo>=${_min_cargo}")
external_connection=true

build() {
  cd "${pkgname}-${pkgver}"
  if type "cargo-${_min_cargo}"; then
    "cargo-${_min_cargo}" build -j"${NCPU}" --release --locked --all-features
  else
    cargo build -j"${NCPU}" --release --locked --all-features
  fi
}

check() {
  cd "${pkgname}-${pkgver}"
  if type "cargo-${_min_cargo}"; then
    RUSTDOC="rustdoc-${_min_cargo}" "cargo-${_min_cargo}" test
  else
    cargo test
  fi
}

package() {
  cd "${pkgname}-${pkgver}"
  install -Dm0755 -t "${pkgdir}/usr/bin/" "target/release/${pkgname}"
}
