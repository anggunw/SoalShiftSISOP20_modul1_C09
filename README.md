# SoalShiftSISOP20_modul1_C09

* [Soal 1](#soal1)
   - [Penyelesaian 1a](#1a)
   - [Penyelesaian 1b](#1b)
   - [Penyelesaian 1c](#1c)
      
* [Soal 2](#soal2)
   - [Penyelesaian 2a](#2a)
   - [Penyelesaian 2b](#2b)
   - [Penyelesaian 2c](#2c)
      
* [Soal 3](#soal3)
   - [Penyelesaian 3](#3)


## Soal 1 <a name="soal1"></a>

Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum untuk membuat laporan berdasarkan data yang ada pada file “Sample-Superstore.tsv”. Namun dia tidak dapat menyelesaikan tugas tersebut. Laporan yang diminta berupa :
a. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling
sedikit
b. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling
sedikit berdasarkan hasil poin a
c. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling
sedikit berdasarkan 2 negara bagian (state) hasil poin b
Whits memohon kepada kalian yang sudah jago mengolah data untuk mengerjakan
laporan tersebut.
*Gunakan Awk dan Command pendukung

**Penyelesaian**

### 1a. <a name="1a"></a>
```
awk 'BEGIN{FS="\t"}
```
BEGIN block dari awk yang menandakan bahwa field separator berupa tab

```
FNR>1{arr[$13]+=$21;reg=$13;min=arr[$13]}
```
* FNR > 1 berarti BODY block dijalankan mulai baris kedua
* arr[$13]+=$21 berarti membuat array dengan nama indeks diambil dari kolom ke 13 (region) dan isi dari array adalah penjumlahan dari kolom ke 21 (profit)
* reg=$13 berarti menyimpan kolom ke-13 dalam 1 baris ke variabel reg
* min=arr[$13] berarti menyimpan isi (profit) dari arr[$13]

```
END{for(i in arr)
      {if(arr[i]<min)
         {min=arr[i];reg=i}
       };
     print reg > "jawaban1.var";
     print reg,min}' Sample-Superstore.tsv
```
* Pada END block dilakukan loop untuk mengecek apakah ada isi dari array yang bernilai lebih kecil dari min. Jika ada, maka isi dari array indeks tersebut disimpan dalam variable min dan nama indeks tersebut disimpan di variable reg
* print reg > "jawaban1.var" berarti isi variable reg disimpan di file jawaban1.var


### 1b. <a name="1b"></a>
```
region=$(cat jawaban1.var)
```
Membaca isi file jawaban1.var dan menyimpannya dalam variable region

```
awk -v reg="$region" 'BEGIN{FS="\t"}
```
Awk -v reg="$region" berarti variable reg dalam awk adalah variable region dalam shell script ini

```
{if($13 == reg){arr[$11]+=$21}}
```
Mengecek nilai dari kolom ke-13(region). Jika isi dari kolom ke-13 sama dengan reg, maka arr[$11]+=$21 dijalankan. Ini akan membuat array dengan nama indeks diambil dari kolom ke 11 (state) dan isi dari array adalah penjumlahan dari kolom ke 21 (profit)

```
END{PROCINFO["sorted_in"]="@val_num_asc";
count=0;
for(i in arr){if(count==2)break;print i > "jawaban2.var";print i,arr[i];count++}}' Sample-Superstore.tsv
```
* PROCINFO["sorted_in"]="@val_num_asc" berarti mensortir array dari nilai terkecil
* Kemudian dilakukan loop untuk mencetak state dengan profit paling sedikit, ketika count/iterasi sudah bernilai 2 maka loop ini dihentikan
* print i > "jawaban2.var" berarti menyimpan nilai i ke dalam file jawaban2.var

### 1c. <a name="1c"></a>
```
states=$(cat jawaban2.var)
state1=$(echo $states | cut -f1 -d' ')
state2=$(echo $states | cut -f2 -d' ')
```
Membaca file jawaban2.var dan menyimpannya ke dalam variable states. Kemudian variable states dipisah ke dalam dua variable yaitu state1 dan state2

```
awk -v st1="$state1" -v st2="$state2" 'BEGIN{FS="\t"}
```
Nilai dari st1 pada awk ini diambil dari variable state1 di script, begitu juga dengan st2 

```
$11 == st1||$11 == st2{arr[$17]+=$21}
```
Seperti soal 1b, akan tetapi kali ini mengecek nilai kolom ke 11 dengan st1 atau st2

```
END{PROCINFO["sorted_in"]="@val_num_asc";
count=0;
for(i in arr){if(count==10)break;print i,arr[i];count++}};' Sample-Superstore.tsv
```
Seperti soal 1b, akan tetapi kali ini mencetak hingga 10 kali


## Soal 2 <a name="soal2"></a>
Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan
data-data penting. Untuk mencegah kejadian yang sama terulang kembali mereka
meminta bantuan kepada Whits karena dia adalah seorang yang punya banyak ide.
Whits memikirkan sebuah ide namun dia meminta bantuan kalian kembali agar ide
tersebut cepat diselesaikan. Idenya adalah kalian (a) membuat sebuah script bash yang
dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf
besar, huruf kecil, dan angka. (b) Password acak tersebut disimpan pada file berekstensi
.txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.
(c) Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan di
enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan
dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal:
password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt
dengan perintah ‘bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan
file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula
seterusnya. Apabila melebihi z, akan kembali ke a, contoh: huruf w dengan jam 5.28,
maka akan menjadi huruf b.) dan (d) jangan lupa untuk membuat dekripsinya supaya
nama file bisa kembali.

**Penyelesaian :**
### 2.A <a name="2a"></a>
#!/bin/bash

arg="$1"
arg=${arg//[^[:alnum:]]/}
arg=${arg//[0-9]/}
#echo "$arg"
cat /dev/urandom| tr -dc 'a-zA-Z0-9'|fold -w 28| head -n 1  >> "$arg".txt

* arg="$1" berarti passgen.sh akan mengambil argumen yang nantinya akan menjadi nama file
* arg=${arg//[^[:alnum:]]/} berarti argumen akan cek apakah ada karakter spesial, jika ada akan dihapus
* arg=${arg//[0-9]/} berarti argumen akan dicek apakah ada angka atau tidak, jika ada maka akan dihapus
* cat /dev/urandom| tr -dc 'a-zA-Z0-9'|fold -w 28| head -n 1  >> "$arg".txt berarti akan membuat password acak yang nantinya akan disimpan dalam txt dengan nama dari argumen yang dimasukkan


### 2.B <a name="2b"></a>
#!/bin/bash

echo "$1"
hour=$(date +%H)

txt="$1"
txt=${txt/txt}
encrypt='[a-z]'

echo "Jam di enkripsi : $hour"

case "$hour" in
"0")
encrypt='[a-z]'
;;
"1")
encrypt='[b-za]'

......

"23")
encrypt='[x-za-w]'
;;

esac

ren=$( echo "$txt" | tr '[a-z]' "$encrypt" )
ren="${ren}txt"

mv "$1" "$ren"

* hour=$(date +%H) berarti nanti hour akan bernilai angka dari jam sekarang
* txt="$1" berarti txt akan berisi argumen pertama yang dimasukkan
* txt=${txt/txt} berarti txt akan menghapus file jika ada nama txt
* case "$hour" in berarti encrypt akan bergantung pada nilai hour
* ren=$( echo "$txt" | tr '[a-z]' "$encrypt" ) berarti ren akan memulai enkripsi
* ren="${ren}txt" berarti ren akan menambahkan file txt diakhir
* mv "$1" "$ren" berarti nama file yang dimasukkan pada argumen akan diganti dengan isi ren

### 2.C <a name="2c"></a>
#!/bin/bash

echo "$1"
hour="$2"

txt="$1"
ori="$txt"
txt=${txt/txt}
encrypt='[A-Z]'


case "$hour" in
"0")
encrypt='[a-z]'
;;
"1")
encrypt='[b-za]'
;;

....

"23")
encrypt='[x-za-w]'
;;

esac

ren=$( echo "$txt" | tr "$encrypt" '[a-z]' )
ren="${ren}txt"

mv "$1" "$ren"
   
* hour="$2" berarti nilai hour akan dimasukkan pada argumen ke 2
* ren=$( echo "$txt" | tr "$encrypt" '[a-z]' ) berarti akan menerjemahkan nama file yang ditaruh pada ren
* mv "$1" "$ren" berarti nama file yang dimasukkan pada argumen akan diganti dengan isi ren


## Soal 3 <a name="soal3"></a>

1 tahun telah berlalu sejak pencampakan hati Kusuma. Akankah sang pujaan hati kembali ke naungan Kusuma? Memang tiada maaf bagi Elen. Tapi apa daya hati yang sudah hancur, Kusuma masih terguncang akan sikap Elen. Melihat kesedihan Kusuma, kalian mencoba menghibur Kusuma dengan mengirimkan gambar kucing. 
[a] Maka dari itu, kalian mencoba membuat script untuk mendownload 28 gambar dari "https://loremflickr.com/320/240/cat" menggunakan command wget dan menyimpan file dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2, pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam sebuah file "wget.log". Karena kalian gak suka ribet, kalian membuat penjadwalan untuk menjalankan script download gambar tersebut. Namun, script download tersebut hanya berjalan
[b] setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu Karena gambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan gambar yang terdownload itu identik. Supaya gambar yang identik tidak dikira Kusuma sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar identik. Setelah memilah gambar yang identik, maka dihasilkan gambar yang berbeda antara satu dengan yang lain. Gambar yang berbeda tersebut, akan kalian kirim ke Kusuma supaya hatinya kembali ceria. Setelah semua gambar telah dikirim, kalian akan selalu menghibur Kusuma, jadi gambar yang telah terkirim tadi akan kalian simpan kedalam folder /kenangan dan kalian bisa mendownload gambar baru lagi. 
[c] Maka dari itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate
dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201). Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253). Setelah tidak ada gambar di current directory, maka lakukan backup seluruh log menjadi ekstensi ".log.bak". Hint : Gunakan wget.log untuk membuat location.log yang isinya merupakan hasil dari grep "Location".
*Gunakan Bash, Awk dan Crontab

**Penyelesaian :**
### 3. <a name="3"></a>
``` 
#!/bin/bash

#3a
a=1
while [[ $a -lt 29 ]]
do
 wget -O pdkt_kusuma_$a loremflickr.com/320/240/cat -a wget.log
 #echo $a
 a=$((a + 1))
done
grep 'Location' wget.log > location.log

mkdir duplicate
mkdir kenangan
echo "Download Selesai"

a=0

if [ $a -eq 0 ]
then
        echo "Filter"
        #3C
        d=1
        k=1
        dir=$(pwd)

        for ((i=1; i<=28; i++))
        do
                for((j=1; j<=28; j++))
                do
                        if [ $i -eq $j ]
                        then
                                z=1
                        elif  cmp -s "pdkt_kusuma_"$i"" "pdkt_kusuma_"$j"" ;
                        then
                                mv "pdkt_kusuma_"$j""  "duplicate_"$d""
                                mv "duplicate_"$d"" duplicate
                                d=$((d+1))
                        else
                        z=0
                        fi
                done

                if [ -f "pdkt_kusuma_"$i"" ]
                then
                        mv "pdkt_kusuma_"$i"" "kenangan_"$k
                        mv "kenangan_"$k"" kenangan
                        k=$((k+1))
                fi
        done
fi

mv "wget.log" "wget.log.bak"
mv "location.log" "location.log.bak"

* while $i -lt 29 berarti melakukan loop sebanyak 28 kali
* wget -O berarti mendownload dari loremflickr.com/320/240/cat dan menyimpannya dengan nama pdkt_kusuma_$i 
* -a wget.log menyimpan log messages dari wget ke file wget.log
* i=$((i+1)) berarti increment i
* grep 'Location' wget.log > location.log berarti mencari kata 'Location' dalam tiap baris di wget.log dan menyimpannya di location.log
* mkdir berarti untuk membuat directory baru yaitu directory duplicate dan directory kenangan
* a=0 digunakan untuk menandakan bahwa download telah selesai dan lanjut ke tahap filter
* dir=$(pwd) berarti var dir berisi lokasi current directory saat ini
* for ((i=1; i<=28; i++)) dan for((j=1; j<=28; j++)) digunakan untuk melakukan looping pengecekan
* if [ $i -eq $j ] digunakan agar file tidak compare file dengan nomor yang sama
* cmp -s "pdkt_kusuma_"$i"" "pdkt_kusuma_"$j"" berarti membandingkan apakah file $i sama dengan $j atau tidak
* mv "pdkt_kusuma_"$j""  "duplicate_"$d"" berarti jika file sama maka file $j mengganti nama jadi duplicate_$d
* mv "duplicate_"$d"" duplicate untuk memindahkan ke directory duplicate setelah ganti nama
* d=$((d+1)) berarti setiap kali ada file yang sama var d akan melakukan increnment

**Penyelesaian :**
### Crontab.

5 6-23/8 * * 0-5 /bin/bash  /home/farrelmt/N3/3.sh

*berarti setiap 8 jam pada jam 06.05 di hari Minggu - Jumat akan menjalankan bash yang berada di directory /home/farrelmt/N3/
