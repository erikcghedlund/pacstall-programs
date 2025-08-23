pkgname='donetick'
pkgver='0.1.53'
pkgdesc='Open-source, user-friendly app for managing tasks and chores, featuring customizable options to help you and others stay organized'
license=("AGPL-3.0-only")
url='https://donetick.com/'
arch=("any")
maintainer=("Erik Hedlund <erikcghedlund@outlook.com>")
source=(
  "backend::https://github.com/donetick/donetick/archive/refs/tags/v${pkgver}.tar.gz"
  "frontend::https://github.com/donetick/frontend/archive/refs/tags/v0.1.40.tar.gz"
)
sha256sums=("SKIP" "SKIP")
makedepends=('node-npm' 'golang')
external_connection=true

prepare() {
  cd "${srcdir}/frontend-0.1.40"
  npx update-browserslist-db@latest
  npm install
  cd "${srcdir}/donetick-${pkgver}"
  go mod download
  rm -rf "./frontend/dist"
}

build() {
  cd "${srcdir}/frontend-0.1.40"
  npm run build-selfhosted
  mv "${srcdir}/frontend/dist" "${srcdir}/backend/frontend"
  cd "${srcdir}/donetick-${pkgver}"
  go build -d donetick .
}

package() {
  install -Dm755 "${srcdir}/backend/donetick" "${pkgdir}/usr/local/bin/donetick"
}
