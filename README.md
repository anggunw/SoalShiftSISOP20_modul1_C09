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
   - [Penyelesaian 3a](#3a)
   - [Penyelesaian 3b](#3b)
   - [Penyelesaian 3c](#3c)


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
### 1. Jalankan soal2_passgen.sh [NAMA_FILE] untuk generate code <a name="2a"></a>
   ex :
   $ bash soal2_passgen.sh password
   
### 2. Untuk enkripsi nama file jalankan soal2_enkripsi.sh [NAMA_FILE] <a name="2b"></a>
   ex :
   $ bash soal2_enkripsi.sh password.txt
   
### 3. Untuk mengembalikan nama file jalankan soal2_dekripsi.sh [NAMA_FILE_ENC] [JAM_ENC] <a name="2c"></a>
   ex :
   $ bash soal2_dekripsi.sh fqiimeht.txt 16
   
   Catatan :
   - [NAMA_FILE] = Nama File yang ingin dienkripsi
   - [NAMA_FILE_ENC] = Nama File yang telah dienkripsi
   - [JAM_ENC] = Waktu File dienkripsi
   

## Soal 3 <a name="soal3"></a>

1 tahun telah berlalu sejak pencampakan hati Kusuma. Akankah sang pujaan hati kembali ke naungan Kusuma? Memang tiada maaf bagi Elen. Tapi apa daya hati yang sudah hancur, Kusuma masih terguncang akan sikap Elen. Melihat kesedihan Kusuma, kalian mencoba menghibur Kusuma dengan mengirimkan gambar kucing. 
[a] Maka dari itu, kalian mencoba membuat script untuk mendownload 28 gambar dari "https://loremflickr.com/320/240/cat" menggunakan command wget dan menyimpan file dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2, pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam sebuah file "wget.log". Karena kalian gak suka ribet, kalian membuat penjadwalan untuk menjalankan script download gambar tersebut. Namun, script download tersebut hanya berjalan
[b] setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu Karena gambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan gambar yang terdownload itu identik. Supaya gambar yang identik tidak dikira Kusuma sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar identik. Setelah memilah gambar yang identik, maka dihasilkan gambar yang berbeda antara satu dengan yang lain. Gambar yang berbeda tersebut, akan kalian kirim ke Kusuma supaya hatinya kembali ceria. Setelah semua gambar telah dikirim, kalian akan selalu menghibur Kusuma, jadi gambar yang telah terkirim tadi akan kalian simpan kedalam folder /kenangan dan kalian bisa mendownload gambar baru lagi. 
[c] Maka dari itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate
dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201). Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253). Setelah tidak ada gambar di current directory, maka lakukan backup seluruh log menjadi ekstensi ".log.bak". Hint : Gunakan wget.log untuk membuat location.log yang isinya merupakan hasil dari grep "Location".
*Gunakan Bash, Awk dan Crontab

**Penyelesaian :**
### 3a. <a name="3a"></a>
``` 
#!/bin/bash
i=1
while [[ $i -lt 29 ]]
do
 wget -O pdkt_kusuma_$i loremflickr.com/320/240/cat -a wget.log
 #echo $i
 i=$((i + 1))
done
grep 'Location' wget.log > location.log
```
* while $i -lt 29 berarti melakukan loop sebanyak 28 kali
* wget -O berarti mendownload dari loremflickr.com/320/240/cat dan menyimpannya dengan nama pdkt_kusuma_$i 
* -a wget.log menyimpan log messages dari wget ke file wget.log
* i=$((i+1)) berarti increment i
* grep 'Location' wget.log > location.log berarti mencari kata 'Location' dalam tiap baris di wget.log dan menyimpannya di location.log

