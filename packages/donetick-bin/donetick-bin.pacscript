pkgname='donetick'
pkgver='0.1.53'
pkgdesc='Open-source, user-friendly app for managing tasks and chores, featuring customizable options to help you and others stay organized'
license=("AGPL-3.0-only")
url='https://donetick.com/'
arch=("arm64" "amd64")
maintainer=("Erik Hedlund <erikcghedlund@outlook.com>")
source=("https://github.com/donetick/donetick/releases/download/v${pkgver}/donetick_Linux_${AARCH}.tar.gz")
sha256sums=("SKIP")
depends=('sqlite3')

package() {
  install -Dm755 "${srcdir}/donetick" "${pkgdir}/usr/local/bin/donetick"
  install -Dm644 "${srcdir}/config/local.yaml" "${pkgdir}/usr/local/etc/donetick/config/local.yaml"
  install -Dm644 "${srcdir}/config/selfhosted.yaml" "${pkgdir}/usr/local/etc/donetick/config/selfhosted.yaml"
}
