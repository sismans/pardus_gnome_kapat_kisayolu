#!/usr/bin/env bash
# Hızlı Kapat - kur.sh ile yapılan kurulumu kaldırır (Pardus 25 GNOME için)
# Yazan: Süleyman ŞİŞMAN
set -euo pipefail

HEDEF="${HOME}/.local"

if [ -x "$HEDEF/bin/hizli-kapat" ]; then
    "$HEDEF/bin/hizli-kapat" --kisayol-kaldir || true
fi
rm -f "$HEDEF/bin/hizli-kapat" "$HEDEF/share/applications/hizli-kapat.desktop"
update-desktop-database "$HEDEF/share/applications" 2>/dev/null || true

echo "Hızlı Kapat kaldırıldı."
echo "(.deb ile kurduysanız bunun yerine: sudo apt remove hizli-kapat)"
