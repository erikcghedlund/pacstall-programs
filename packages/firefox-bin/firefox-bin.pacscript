pkgname="firefox-bin"
gives="firefox"
pkgver="139.0.4"
repology=("project: ${gives}")
replaces=("${gives}-deb" "${gives}-arm64-deb")
source=("https://ftp.mozilla.org/pub/firefox/releases/${pkgver}/linux-${AARCH}/en-US/firefox-${pkgver}.tar.xz")
url='https://www.mozilla.org/en-US/firefox'
optdepends=("speech-dispatcher: Common interface to speech synthesizers")
pkgdesc="Free and open-source web browser developed by the Mozilla Foundation"
maintainer=("Oren Klopfer <oren@taumoda.com>")
arch=('amd64' 'arm64')
sha256sums_amd64=("fe22686f09a0c46390fea430b26cccc323d92af26869699f394f25b5e71527a3")
sha256sums_arm64=("b59b346c9e671de73ffa4f5b5c72b98a91918849d31988c3251f8e91bdbb72b6")

package() {
  cd "${srcdir}"
  mkdir -p "${pkgdir}/lib/firefox"
  cp -r firefox/* "${pkgdir}/lib/firefox"
  for i in 16 32 48 64 128; do
    mkdir -p "${pkgdir}/usr/share/icons/hicolor/${i}x${i}/apps"
    ln -s "/lib/firefox/browser/chrome/icons/default/default${i}.png" "${pkgdir}/usr/share/icons/hicolor/${i}x${i}/apps/firefox.png"
  done
  chmod +x "${pkgdir}/lib/firefox/firefox"
  chmod +x "${pkgdir}/lib/firefox/firefox-bin"
  mkdir -p "${pkgdir}/usr/share/applications/"
  echo '[Desktop Entry]
Name=Firefox Stable
Comment=Web Browser
Exec=/lib/firefox/firefox %u
Terminal=false
Type=Application
Icon=firefox
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
Actions=Private;

[Desktop Action Private]
Exec=/lib/firefox/firefox --private-window %u
Name=Open in private mode' | tee "${pkgdir}/usr/share/applications/firefox.desktop" > /dev/null
  mkdir -p "${pkgdir}/usr/bin"
  ln -sf "/lib/firefox/firefox-bin" "${pkgdir}/usr/bin/firefox-bin"
  ln -sf "/lib/firefox/firefox" "${pkgdir}/usr/bin/firefox"
}
