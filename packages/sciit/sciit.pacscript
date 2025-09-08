pkgname="sciit"
pkgver="2.1.2"
pkgdesc="An extension to git that embeds issue tracking in source control artifacts, integrating issue tracking and management into a project's change control process."
arch=('any')
url='https://gitlab.com/sciit/sciit'
depends=('python3>=3.7' 'sqlite3>=3.8.2' 'git>=2.26'
  'python3-markdown2>=2.3'
  'python3-argcomplete>=1.12'
  'python3-gitdb>=2.0'
  'python3-termcolor>=1.1'
  'python3-slugify>=1.2'
  'python3-colorama>=0.4'
  'python3-flask>=1.0'
  'python3-pathspec>=0.5'
  'python3-gitlab>=2.5'
  'python3-dateutil>=2.7'
  'python3-requests>=2.25'
  'python3-git'
)
makedepends=(
  'python3-build'
  'python3-installer'
  'python3-setuptools'
  'python3-wheel'
)
source=("https://gitlab.com/${pkgname}/${pkgname}/-/archive/v${pkgver}/${pkgname}-v${pkgver}.tar.gz")
sha256sums=("ebb7f3dfe4f286125a31fd5002b8a034b826d17086dc5d7cf22b0f64b8547468")
maintainer=("Erik Hedlund <erikcghedlund@outlook.com>")
external_connection=true

package() {
  cd "${srcdir}/${pkgname}-v${pkgver}"
  python3 setup.py install_wr --root="${pkgdir}" --optimize=1
  python3 setup.py install --root="${pkgdir}" --optimize=1
  install -Dm644 "${pkgname}/man/LICENSE" "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE"
}
