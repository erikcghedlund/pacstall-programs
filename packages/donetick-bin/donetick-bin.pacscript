pkgname='donetick-bin'
gives='donetick'
pkgver='0.1.53'
pkgdesc='Open-source, user-friendly app for managing tasks and chores, featuring customizable options to help you and others stay organized'
license=('AGPL-3.0-only')
url='https://donetick.com/'
arch=("arm64" "amd64")
maintainer=("Erik Hedlund <erikcghedlund@outlook.com>")
source=("https://github.com/donetick/donetick/releases/download/v${pkgver}/donetick_Linux_${AARCH}.tar.gz")
sha256sums_amd64=("a25fe39e29ae6ead22a80512ec348b5fa56df1e7b94d383a42c6f799bc4745c4")
sha256sums_arm64=("cd7dd65c7aa56d27f899a1395acd195b3319fd4bad7c74c7eef08eafb3576b33")
depends=('sqlite3')

package() {
  install -Dm755 "${srcdir}/${gives}" "${pkgdir}/usr/local/bin/${gives}"
  install -Dm644 "${srcdir}/config/local.yaml" "${pkgdir}/usr/local/etc/${gives}/config/local.yaml"
  install -Dm644 "${srcdir}/config/selfhosted.yaml" "${pkgdir}/usr/local/etc/${gives}/config/selfhosted.yaml"
}

post_install() {
  groupadd --system donetick
  useradd --system --shell '/usr/sbin/nologin' --gid donetick donetick
  chown -R donetick:donetick "/usr/local/etc/${gives}/"
}

post_remove() {
  userdel donetick
}
