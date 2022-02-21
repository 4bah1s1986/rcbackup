# 4bah1s-rcbackup

Disediakan oleh : Abdul Wahid bin Ani

## Pendahuluan

Skrip dibuat untuk server yang disediakan menggunakan Runcloud dimana Runcloud menggunakan struktur folder web seperti contoh berikut.
> /home/contohuser/webapps/web-blog1

Runcloud sendiri menawarkan servis backup yang boleh dilanggan. Oleh itu penggunaan skrip ini merupakan alternatif kepada servis yang disediakan. Namun, buat masa ini skrip ini tidak disertakan sekali dengan skrip untuk restore semula web daripada backup yang telah dibuat. Anda boleh restore secara manual menggunakan arahan tar dan mysql.

Untuk keselamatan fail backup yang dibuat, folder yang digunakan untuk menyimpan backup boleh diasingkan di dalam storan berlainan pada server yang sama ataupun boleh juga mount folder backup tersebut dengan NFS server.

## Struktur fail dan folder

Skrip terdiri dari :-

 - Satu executable script bernama 'backup.sh'
 - Fail konfigurasi utama bernama '**config**' yang perlu disediakan dari config.sample
 - Fail konfigurasi bagi setiap laman web yang mahu di backup (**Format .conf**). Fail konfigurasi perlu disediakan dengan menyalin/merujuk fail 'sample.conf.sample' di dalam **folder 'setbackup'.**

## Kandungan fail konfigurasi

### Fail 'config'

    BACKUP_DIR=/backup
    SAVE_BACKUP_DURATION=3
    BACKUP_PREFIX="RC-"
    BACKUP_SUFFIX=$(date +%Y%m%d%H%M)
 
### Fail dengan format '.conf' di dalam folder 'setbackup'

Rujuk 'setbackup/sample.conf.sample'

Terdapat pilihan konfigurasi untuk menyokong keadaan samaada laman web menggunakan database local ataupun remote.
 
## Cron - Jalankan backup secara automatik

Taip 'crontab -e' dan set backup seperti contoh berikut. Contoh diberi adalah untuk menjalankan backup secara harian pada jam 12 malam.

    0 0 * * * /opt/script/rcbackup/backup.sh  > /dev/null 2>&1
