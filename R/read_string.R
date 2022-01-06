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
#'   "A 112 20
#'  YY 18 10
#'  XX 15 15
#'  DD 25 28"
#'
#' read_string(s1)
#' read_string(s1, header = TRUE)
#' read_string(s1, tranpose = TRUE, header = FALSE)
#' read_string(s1, tranpose = TRUE, header = TRUE, col_names = LETTERS[1:4])
#' read_string(s1, tranpose = TRUE, col_names = letters[1:4])
read_string <- function(s, col_names = NULL, header = FALSE, tranpose = FALSE, ...) {
  dat <- utils::read.table(textConnection(s), header = ifelse(header & !tranpose, TRUE, FALSE), ...)
  if (tranpose) {
    dat <- as.data.frame(t(dat))
    if (header) dat <- `colnames<-`(dat[-1, ], dat[1, ])
    rownames(dat) <- NULL
  }
  if (!is.null(col_names)) dat <- `colnames<-`(dat, col_names)
  return(dat)
}
