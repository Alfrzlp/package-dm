# Package dm

hanya sebuah package untuk penggunaan pribadi. untuk menunjang pekerjaan sehari-hari

<hr>
# Workflow membuat package di R
## 1. Inisialisasi
mengecek apakah nama package kita belum dipakai orang atau tidak
```
available::available('vgwr')
```

1. New Project -> R Package

### Cara lain untuk inisialisasi
```{r}
library(devtools)
create_package("path/to/mynamepackage")
```
Folder `R` akan berisi semua function. setiap function akan ada 1 R script. Sedangkan `man` akan berisi dokumentasi menggenai setiap function

## 2. Menghubungkan dengan github/gitlab

1. Buat repository di github. lalu jalankan perintah berikut di terminal (pastikan lokasi terminal sudah di folder package)
```
git init
git add .
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/Alfrzlp/my_repo.git
git push -u origin main
```
### Cara lain jika ada suka pakai Rstudio
buat Rscript kosong terserah. jalankan perintah berikut. (tidak disave juga tidak mengapa) tapi save lebih baik misal diberinama `myworkflow.R`
```{r}
use_git(message = 'first commit')
use_git_remote(name = 'origin', url = 'https://github.com/Alfrzlp/my_repo.git')
```
saya lebih suka menggunakan terminal daripada dari Rstudio

buka `Tools - version control - Project setup` pastikan telah terhubung dengan repository kita
<img width="440" alt="image" src="https://user-images.githubusercontent.com/74123953/147713182-cf5eb1c0-3228-46b2-8ae0-9cd287b56ae8.png">


## 3. Membuat sebuah function

sebagai contoh akan membuat sebuah fungsi bernama read_string. jalan perintah ini pada `myworkflow.R`
```{r}
use_r('read_string')
```
anda akan diarah kepada file `read_string.R` silahkan isi dengan fungsi yang anda inginkan.
misalnya :
```{r}
read_string <- function(s, col_names = NULL, header = FALSE, tranpose = FALSE, ...){
  dat <- utils::read.table(textConnection(s), header = ifelse(header & !tranpose, TRUE, FALSE), ...)
  if(tranpose){
    dat <- as.data.frame(t(dat))
    if(header) dat <- `colnames<-`(dat[-1,], dat[1,])
    rownames(dat) <- NULL
  }
  if(!is.null(col_names)) dat <- `colnames<-`(dat, col_names)
  return(dat)
}
```
jangan lupa jika menggunakan sebuah fungsi dari package lain untuk mencantumkan asal dari packagenya seperti `utils::read.table()` meskipun itu dari package utils. agar tidak terjadi konflik antar package ketika ada kesamaan nama fungsi

## 4. Menambahkan Dokumentasi pada fungsi
letakan kursor pada fungsi lalu pilih `code -> insert roxygen skeleton`. contoh pengisisan :

```{r}
#' Membaca data.frame dari string
#'
#' @param s string
#' @param col_names nama kolom yang diigninkan, default adalah V1, V2 ...
#' @param header logical. apakah data.frame menggandung header
#' @param tranpose logical. apakah perlu tranpose
#' @param ... parameter untuk `read.table`
#'
#' @return data.frame
#' @export
#'
#' @examples
#' s1 <-
#' 'A 112 20
#'  YY 18 10
#'  XX 15 15
#'  DD 25 28'
#'
#' read_string(s1)
#' read_string(s1, header = TRUE)
#' read_string(s1, tranpose = TRUE, header = FALSE)
#' read_string(s1, tranpose = TRUE, header = TRUE, col_names = LETTERS[1:4])
#' read_string(s1, tranpose = TRUE, col_names = letters[1:4])

read_string <- function(s, col_names = NULL, header = FALSE, tranpose = FALSE, ...){
  dat <- utils::read.table(textConnection(s), header = ifelse(header & !tranpose, TRUE, FALSE), ...)
  if(tranpose){
    dat <- as.data.frame(t(dat))
    if(header) dat <- `colnames<-`(dat[-1,], dat[1,])
    rownames(dat) <- NULL
  }
  if(!is.null(col_names)) dat <- `colnames<-`(dat, col_names)
  return(dat)
}
```
jangan lupa save file

## 5. Dokumentasi tentang package
buat sebuah Rscript `my_package.R` di folder R. fungsinya isi NULL lalu sama seperti diatas
```
#' my_package: A package for data manipulation
#'
#' The my_package package provides three categories of important functions:
#' str2vec, read_img and many more
#'
#' @section Foo functions:
#' The foo functions ...
#'
#' @docType package
#' @name my_package
NULL

```
## 6. Pengujian dari fungsi
jalankan ini pada `myworkflow.R` untuk meload library kita. kita bisa langsung menggunakannnya
```{r}
load_all()
```

jika anda coba lihat dokumentasi fungsi `?read_string` masih belum ada. ada bisa jalankan perintah ini
```
document()
```

## 7. dependensi package lain
jika anda ada menggunakan package lain. maka jalankan perintah seperti berikut di `myworkflow.R`
```{r}
use_package("stringr")
use_package('reticulate')
use_package('tesseract')
use_package('tidyr')
use_package('dplyr')
```
## 8. Package siap diinstall apa nggak ya?
tinggal cek aja dengan
```
check()
```
siap install nih? kita coba install di Rstudio kita
```
install()
```
coba close project dan lihat di daftar package, nanti akan ada package kita

## 9. Finishing
penulisan syntax yang amburadul perlu dirapiin. jalankan perintah berikut `myworkflow.R` dan lihat bedanya pada setiap script fungsi kita
```
styler::style_pkg() # restyles an entire R package.
styler::style_dir() # restyles all files in a directory.
```

## 10. Lisensi
anda bisa pakai yang lainnya juga
```
use_mit_license("Ridson Alfarizal")
```

## 11. Install di tempat orang lain
push perubahan ke github dan bisa coba install ke orang lain
```
devtools::install_github('alfrzlp/my_repo')
```

# Kesimpulan 
alurnya
- buat fungsi `use_r('nama_fungsi')` dan tambah dokumentasi
- test fungsi `load()` jangan lupa `document()` untuk generate dokumentasi fungsi
- tambah dependensi package jika ada
- test keseluruhan dengan `check()`
- push ke github
- turu 
