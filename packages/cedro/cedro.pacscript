pkgname="cedro"
pkgdesc="C language extension that works as a pre-processor"
#repology=("project: blesh")
arch=("any")
breaks=("${pkgname}-git")
url='https://sentido-labs.com/en/library/?filter=cedro'
pkgver="1.0.10"
source=("https://sentido-labs.com/blake3/1e2b67d9/9868bc98/66f814db/688b135c/dafb9899/1df3858a/f05d135f/ea379f6a/e4bc637e/6f3a3a5c/a10861b7/040d3b09/6f0715cd/0aba45cc/b65d5ebe/ec9b53c2/${pkgname}-${pkgver}_20230321.tbz2")
sha256sums=("9bbf54a55bfb0b65abe2409ae601d195d4c4e87ecab3f588995fbec8048ad2f3")
checkdepends=("valgrind" "sparse" "gcc" "make")
license=("Apache-2.0")
maintainer=("Erik Hedlund <erikcghedlund@outlook.com>")
_flags=()

package() {
  install -Dm755 "${srcdir}/${pkgname}/bin/${pkgname}" "${pkgdir}/usr/local/bin/${pkgname}"
  install -Dm755 "${srcdir}/${pkgname}/bin/${pkgname}cc" "${pkgdir}/usr/local/bin/${pkgname}cc"
  install -Dm644 "${srcdir}/${pkgname}/LICENSE" "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE"
}

prepare() {
  mkdir "${srcdir}/${pkgname}/bin"
}

build() {
  cd "${srcdir}/${pkgname}"
  cc -o "bin/${pkgname}" -std=c99 -march=native -O2 "src/cedro.c"
  sh -c "bin/${pkgname} --insert-line-directives src/${pkgname}cc.c | cc -std=c99 -march=native -O2 -I src -x c -o bin/${pkgname}cc -"
}

check() {
  make -C "${srcdir}/${pkgname}" check
}
