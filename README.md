# Hızlı Kapat
Pardus 25 GNOME için bilgisayarı kapatma onay penceresi.

Pardus GNOME'da Alt+F4 yalnızca açık pencereyi kapatır, kapatma menüsünü açmaz. Hızlı Kapat bu boşluğu doldurur: bir klavye kısayoluyla (varsayılan Süper+K) "Bilgisayarı kapatmak istiyor musunuz?" penceresini açar, onaylarsanız bilgisayarı kapatır.

Varsayılan düğme İptal'dir; yanlışlıkla Enter'a basarsanız bilgisayar kapanmaz.
Kısayolu tek komutla kurar, çakışma varsa sizi uyarır.
Python 3 ve GTK3 eksikse otomatik kurulur.

Gereksinimler ve test durumu
Pardus 25 GNOME (Wayland oturumunda denenmiştir)
Python 3, python3-gi, gir1.2-gtk-3.0 (Pardus 25 GNOME'da hazır gelir; eksikse kurulum sırasında otomatik eklenir)
Başka bir masaüstünde (ör. Pardus XFCE) onay penceresi çalışır, ancak --kisayol-kur yalnızca GNOME içindir. Orada klavye ayarlarından hizli-kapat komutunu elle bir tuşa atayabilirsiniz.

Geliştirme
python3 -m unittest discover -v   # testler (gerçek ayarlarınıza dokunmaz)
bash paketle.sh                   # dist/ altında .deb üretir
Lisans
MIT. Ayrıntı için LICENSE dosyasına bakın. © 2026 Süleyman ŞİŞMAN
