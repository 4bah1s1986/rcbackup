# 4bah1s-rcbackup

Disediakan oleh : Abdul Wahid bin Ani

## Pendahuluan

Skrip dibuat untuk server yang disediakan menggunakan Runcloud dimana Runcloud menggunakan struktur folder web seperti contoh berikut.
> /home/contohuser/webapps/web-blog1

Runcloud sendiri menawarkan servis backup yang boleh dilanggan. Oleh itu penggunaan skrip ini merupakan alternatif kepada servis yang disediakan. Namun, buat masa ini skrip ini tidak disertakan sekali dengan skrip untuk restore semula web daripada backup yang telah dibuat. Anda boleh restore secara manual menggunakan arahan tar dan mysql.

Untuk keselamatan fail backup yang dibuat, folder yang digunakan untuk menyimpan backup boleh diasingkan di dalam storan berlainan pada server yang sama ataupun boleh juga mount folder backup tersebut dengan NFS server.

## Struktur fail dan folder

    backup.sh
	config
	config.sample
	setbackup/
		web1.conf
		web2.conf

**Fail 'config'**
Perlu disediakan dengan membuat salinan fail config.sample

**Folder 'setbackup'**
Fail 'web1.conf' dan 'web2.conf' hanyalah contoh. Fail dengan sambungan '.conf' perlu disediakan dengan tetapan yang betul bagi web yang mahu dimasukkan dalam backup. 

## Kandungan fail 'config'

    SCRIPT_FOLDER=/opt/script/rcbackup
    BACKUP_DIR=/backup
    SAVE_BACKUP_DURATION=3
    BACKUP_PREFIX="RC-"
    BACKUP_SUFFIX=$(date +%Y%m%d%H%M)
 
Konfigurasi di asingkan dari fail utama agar kod mudah diuruskan menggunakan git dan juga diubah berdasarkan keperluan.

## Kandungan folder 'setbackup'

Setiap folder web yang mahu di backup perlu dimasukkan dalam fail dengan sambungan '.conf' yang berlainan. Ia perlu dibuat berdasarkan dua keadaan berikut :-

 **Jika web menggunakan database dalam server yang sama**
  
     contohuser
     webfolder
     1
     dbname

Contoh :- Fail web-client1.conf

     client1
     web-client1
     1
     client-agensi1

 **Jika web menggunakan database dalam server yang berbeza**

    contohuser
    webfolder
    0
    dbname
    dbhost
    dbuser
    dbpassword

Contoh :- Fail web-client2.conf

    client2
    web-client2
    0
    web-client2
    dbserver.sekian.sekian
    client2-usr
    p@ssworddbblabla
 
## Cron - Jalankan backup secara automatik

Taip 'crontab -e' dan set backup seperti contoh berikut. Contoh diberi adalah untuk menjalankan backup secara harian pada jam 12 malam.

    0 0 * * * /opt/script/rcbackup/backup.sh  > /dev/null 2>&1