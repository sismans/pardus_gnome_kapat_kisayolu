#!/usr/bin/env bash
# Hızlı Kapat - kullanıcı düzeyinde kurulum (Pardus 25 GNOME için)
# Yazan: Süleyman ŞİŞMAN
#
# Yönetici yetkisi yalnızca Python/GTK eksikse gerekir; program kendi ev
# klasörünüze (~/.local) kurulur.
set -euo pipefail

KLASOR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HEDEF="${HOME}/.local"
GEREKEN_PAKETLER=(python3 python3-gi gir1.2-gtk-3.0)

gereksinimler_tamam_mi() {
    python3 -c 'import gi; gi.require_version("Gtk", "3.0"); from gi.repository import Gtk' 2>/dev/null
}

if ! gereksinimler_tamam_mi; then
    echo "Python 3 veya GTK bileşenleri eksik, Pardus depolarından kurulacak:"
    echo "  ${GEREKEN_PAKETLER[*]}"
    echo "(İnternet bağlantısı ve yönetici parolanız gerekir.)"
    sudo apt-get install -y "${GEREKEN_PAKETLER[@]}"
    if ! gereksinimler_tamam_mi; then
        echo "Hata: Gerekli paketler kurulamadı. Elle deneyin:" >&2
        echo "  sudo apt install ${GEREKEN_PAKETLER[*]}" >&2
        exit 1
    fi
fi

install -Dm755 "$KLASOR/src/hizli-kapat" "$HEDEF/bin/hizli-kapat"
mkdir -p "$HEDEF/share/applications"
# Menü girdisi ~/.local/bin PATH'te olmasa da çalışsın diye tam yol yazılır.
sed "s|^Exec=hizli-kapat|Exec=$HEDEF/bin/hizli-kapat|" \
    "$KLASOR/data/hizli-kapat.desktop" > "$HEDEF/share/applications/hizli-kapat.desktop"
chmod 644 "$HEDEF/share/applications/hizli-kapat.desktop"
update-desktop-database "$HEDEF/share/applications" 2>/dev/null || true

echo "Hızlı Kapat kuruldu: $HEDEF/bin/hizli-kapat"

if [ -t 0 ]; then
    read -r -p "Süper+K kapatma kısayolu eklensin mi? [E/h] " cevap
    case "${cevap:-E}" in
        [Ee]*) "$HEDEF/bin/hizli-kapat" --kisayol-kur || true ;;
        *) echo "Sonra eklemek için: hizli-kapat --kisayol-kur" ;;
    esac
else
    echo "Süper+K kısayolunu eklemek için: $HEDEF/bin/hizli-kapat --kisayol-kur"
fi
