#' Mengektrak data.frame dari string berdasarkan pola
#'
#' @param s input string
#' @param pos_non_angka posisi kolom yang merupakan non angka
#' @param pos_angka posisi kolom yang merupakan angka
#' @param col_names nama kolom yang diinginkan. default akan v1, v2 ...
#' @param sep pemisah antar kolom. default adalah spasi
#' @param pattern pola dari data.frame jika anda tidak ingin mengisi `pos_non_angka` dan `pos_angka`
#' @param ... parameter untuk fungsi `extract`
#'
#' @return data.frame
#' @export
#'
#' @examples
#' s1 <-
#'   "David howw -.01 .01 0.01 very good -1 -22,1 333 bad .01
#'  marie jane -.01 .01 0.01 moderate -1 -22.1 33.3 not bad  99."
#'
#' read_pattern(
#'   s1,
#'   pos_non_angka = c(1, 5, 9),
#'   pos_angka = c(2:4, 6:8, 10)
#' )
#'
#' s2 <-
#'   "lala 1101180 ; 3D52
#'  john 1119110 ; 3SK3"
#'
#' read_pattern(
#'   s2,
#'   pattern = "(nonangka)\\s(angka)\\s;\\s(nonangka)",
#'   col_names = c("nama", "nim", "kelas")
#' )
read_pattern <- function(
                         # parameter
                         s, pos_non_angka = NULL, pos_angka = NULL,
                         col_names = paste0("v", 1:length(c(pos_non_angka, pos_angka))),
                         sep = "\\s",
                         pattern = NULL,
                         ...) {
  args <- is.numeric(pos_non_angka) + is.numeric(pos_angka)
  ak <- "(-*\\d*,*\\.*\\d*|\\d*)"
  non_ak <- "(\\X*)"

  # Function
  pattern <- c()
  if (is.null(pattern) & args <= 2) {
    if (!is.null(pos_non_angka)) pattern[pos_non_angka] <- non_ak
    if (!is.null(pos_angka)) pattern[pos_angka] <- ak

    pattern <- paste0(pattern, collapse = sep)
  } else if (!is.null(pattern) & args == 0) {
    # pert True untuk melihat belakang ada ( atau tidak (?<=yg dicari)
    pattern <- gsub("(?<=\\()\\s*angka", "-*\\\\d*,*\\\\.*\\\\d*|\\\\d*", pattern, ignore.case = T, perl = T)
    pattern <- gsub("(?<=\\()\\s*non_*\\s*angka", "\\\\X*", pattern, ignore.case = T, perl = T)
  } else {
    warning("Silahkan isi minimal salah satu`pos_non_angka` dan `pos_angka` dengan numeric vector. jika anda ingin custom silakan isi `pattern` dan biarkan kosong `pos_non_angka` dan `pos_angka`")
  }

  tidyr::extract(
    data.frame(
      st = stringr::str_trim(
        stringr::str_split(s, pattern = "\\n")[[1]],
        side = 'both'
      )
    ),
    col = 1, into = col_names, regex = pattern, ...
  )
}
