#' Copy data.frame R ke dalam Clipboard
#'
#' @param df DataFrame yang ingin di copy
#' @param dec format desimal, default dengan koma
#' @param rownames apakah nama baris ikut dicopy?
#' @param colnames apakah nama kolom ikut dicopy?
#' @param ... parameter untuk `write.table`
#'
#' @return tidak ada (silahkan coba paste di spreadshet atau lainnya)
#' @export
#'
#' @examples
#' copy2c(iris)
copy2c <- function(df, dec = ",", rownames = F, colnames = F, ...) {
  utils::write.table(df, "clipboard",
    dec = dec, row.names = rownames,
    col.names = colnames, sep = "\t",
  )
}
