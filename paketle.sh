#!/usr/bin/env bash
# Hızlı Kapat - .deb paketi üretir (Pardus 25 GNOME için)
# Yazan: Süleyman ŞİŞMAN
#
# Kullanım: ./paketle.sh   ->   dist/hizli-kapat_<sürüm>_all.deb
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

PAKET=hizli-kapat
SURUM="$(sed -n 's/^SURUM = "\(.*\)"/\1/p' src/hizli-kapat)"
[ -n "$SURUM" ] || { echo "Hata: sürüm src/hizli-kapat içinde bulunamadı" >&2; exit 1; }

KOK="$(mktemp -d)"
trap 'rm -rf "$KOK"' EXIT
chmod 755 "$KOK"

install -Dm755 src/hizli-kapat "$KOK/usr/bin/$PAKET"
install -Dm644 data/hizli-kapat.desktop "$KOK/usr/share/applications/$PAKET.desktop"
install -Dm644 LICENSE "$KOK/usr/share/doc/$PAKET/copyright"
install -Dm644 README.md "$KOK/usr/share/doc/$PAKET/README.md"

BOYUT="$(du -sk "$KOK/usr" | cut -f1)"
mkdir -p "$KOK/DEBIAN"
cat > "$KOK/DEBIAN/control" <<EOF
Package: $PAKET
Version: $SURUM
Section: utils
Priority: optional
Architecture: all
Installed-Size: $BOYUT
Depends: python3, python3-gi, gir1.2-gtk-3.0
Maintainer: Süleyman ŞİŞMAN
Description: Pardus 25 GNOME için hızlı bilgisayar kapatma penceresi
 Bilgisayarı kapatmadan önce onay soran küçük bir pencere gösterir.
 Süper+K gibi bir klavye kısayoluna bağlanabilir (hizli-kapat --kisayol-kur).
 Python 3 ve GTK3 bağımlılıkları paketle birlikte otomatik kurulur.
EOF

mkdir -p dist
dpkg-deb --build --root-owner-group "$KOK" "dist/${PAKET}_${SURUM}_all.deb"
echo "Hazır: dist/${PAKET}_${SURUM}_all.deb"
