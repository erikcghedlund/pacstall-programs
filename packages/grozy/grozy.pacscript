# Maintainer: danieltetraquark

pkgname='grocy'
pkgver='4.5.0'
pkgdesc="web-based self-hosted groceries & household management solution for your home"
depends=('php' 'php-sqlite3' 'php-gd' 'php-intl' 'php-mbstring')
makedepends=('composer' 'git' 'node-npm')
breaks=("${pkgname}-bin" "${pkgname}-git")
license=('MIT')
arch=('any')
url='https://grocy.info/'
source=("https://github.com/grocy/grocy/archive/v${pkgver}.tar.gz")
sha246sums=('99369c138e9ebbb61590ac7b6f7ee4f2062d3f47c3d11ca2aca5528392c9701a')
backup=('etc/webapps/grocy/config.php')
maintainer=("Erik Hedlund <erikcghedlund@outlook.com>")
external_connection=true

build() {
  cd "${srcdir}/${pkgname}-${pkgver}"

  # composer need to have php-gd extension enabled, otherwise it will fail for a dependency of grocy.
  # note: you may need to adjust your php open_basedir setting, so that php can run!
  #    php -n -dextension=gd.so -dextension=intl.so /usr/bin/composer install --no-interaction --no-dev --optimize-autoloader
  #    php /usr/bin/composer clear-cache

  #yarnpkg install --cwd "${srcdir}/${pkgname}-${pkgver}" --use-yarnrc "${srcdir}/${pkgname}-${pkgver}/.yarnrc"
  npm install
  #yarnpkg cache clean
}

package() {
  cd "${srcdir}/${pkgname}-${pkgver}"

  _instdir="${pkgdir}/usr/share/webapps/grocy"
  mkdir -p "${_instdir}" "${pkgdir}/etc/webapps/grocy" "${pkgdir}/var/lib/webapps"

  # install license
  install -Dm644 LICENSE "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE"

  # copy files to install directory
  cp -ra . "${_instdir}/"

  mv "${pkgdir}/usr/share/webapps/grocy/data" "${pkgdir}/var/lib/webapps/grocy"

  ln -s "/var/lib/webapps/grocy" "${pkgdir}/usr/share/webapps/grocy/data"

  ln -s "/etc/webapps/grocy/config.php" "${pkgdir}/var/lib/webapps/grocy/config.php"

  mv "config-dist.php" "${pkgdir}/etc/webapps/grocy/config.php"

  chown -R 'www-data:www-data' "${pkgdir}"/var/lib/webapps/grocy
}
