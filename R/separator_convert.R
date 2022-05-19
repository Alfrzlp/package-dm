#' Merubah Separator dari beberapa kolom tipe string secara sekaligus
#'
#' @param dat data.frame atau tibble
#' @param col kolom yang ingin dirubah
#' @param sep pemisah asal, default adalah koma
#' @param to_sep pemisah tujuan, default adalah titik
#' @param to_numeric ubah kolom tersebut menjadi numeric ?
#'
#' @return data.frame
#' @export
#'
#' @examples
#'
#' # Input String
#' s2 <- "Melalui Transaksi Penjualan	9	4,6	28	14,4	16	8,2
#' Tidak Melalui Transaksi Penjualan	24	12,4	85	43,8	32	16,5
#' Melalui Transaksi Penjualan	14	14,1	24	24,2	17	17,2
#' Tidak Melalui Transaksi Penjualan	10	10,1	18	18,2	16	16,2"
#'
#' dat <- read_pattern(s2, pos_non_angka = 1, pos_angka = 2:7)
#' dat <- separator_convert(dat, v2:v7)
#' dat
separator_convert <- function(dat, col, sep = ",", to_sep = "\\.", to_numeric = T) {
  if (to_numeric) {
    dat <- dplyr::mutate_at(
      dat, dplyr::vars(!!dplyr::enquo(col)), ~ as.numeric(gsub(sep, to_sep, .x))
    )
  } else {
    dat <- dplyr::mutate_at(
      dat, dplyr::vars(!!dplyr::enquo(col)), ~ gsub(sep, to_sep, .x)
    )
  }
  return(dat)
}
