pkgname="discord-canary"
repology=("project: discord-canary")
pkgver="0.0.702"
maintainer=("DismissedGuy <me@mikealmel.ooo>")
source=("@${pkgname}~${pkgver}::https://canary.dl2.discordapp.net/apps/linux/${pkgver}/${pkgname}-${pkgver}.tar.gz")
url='https://discord.com/'
depends=("libc6" "libasound2" "libatomic1" "libnotify4" "libnspr4" "libnss3" "libstdc++6" "libxss1" "libxtst6" "libc++1" "libatk1.0-0" "libatk-bridge2.0-0" "libcups2" "libdrm2" "libgtk-3-0" "libgbm1")
pkgdesc="Chat for Communities and Friends - Unstable"
arch=('amd64')
sha256sums=("39c446ab07f5df23e76c3a583b25d980440dff35ac8545df685e607a22deb657")

prepare() {
  mkdir -p "${pkgdir}/usr/bin"
  mkdir -p "${pkgdir}/usr/share/${pkgname}"
}

package() {
  cp -r "${pkgname}~${pkgver}"/* "${pkgdir}/usr/share/${pkgname}"
  ln -sf "/usr/share/${pkgname}/DiscordCanary" "${pkgdir}/usr/bin/${pkgname}"
  install -Dm755 "${pkgname}~${pkgver}/discord-canary.desktop" "${pkgdir}/usr/share/applications/discord-canary.desktop"
  install -Dm755 "${pkgname}~${pkgver}/discord.png" "${pkgdir}/usr/share/icons/discord-canary.png"
}

post_install() {
  if ! [[ -f "${homedir}/.config/discordcanary/settings.json" ]]; then
    mkdir -p "${homedir}/.config/discordcanary/"
    echo '{
    "SKIP_HOST_UPDATE": true
}' > "${homedir}/.config/discordcanary/settings.json"
  fi
}
