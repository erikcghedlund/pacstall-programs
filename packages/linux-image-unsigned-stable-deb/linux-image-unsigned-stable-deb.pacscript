pkgname="linux-image-unsigned-stable-deb"
gives="linux-image-unsigned-6.15.1-061501-generic"
pkgver="6.15.1"
buildver="6.15.1-061501.202506041425"
arch=('arm64' 'amd64')
sha256sums_arm64=("b24229f7a90fde4d7e1f73b13b4f6f3c59bdcdf65f35c1bfba64c6b7dfe4730f")
sha256sums_amd64=("517e306c0f3c6cf85ad3cafe944e42a753f55acaf0b18c0a950cc4959d544bad")
source=("https://kernel.ubuntu.com/~kernel-ppa/mainline/v${pkgver}/${CARCH}/${gives}_${buildver}_${CARCH}.deb")
pkgdesc="Ubuntu Linux stable kernel (Unsigned image)"
pacdeps=("linux-headers-generic-stable-deb" "linux-modules-stable-deb")
maintainer=("Oren Klopfer <oren@taumoda.com>")
repology=("project: linux" "repo: distrowatch")
