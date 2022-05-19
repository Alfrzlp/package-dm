#' Mendapatkan Perbedaan dari 2 vector dari kedua sisi
#'
#' @param x vector
#' @param y vector
#'
#' @return data.frame
#' @export
#'
#' @examples
#' x <- c("Tegal Waru", "Purwakarta", "Saguling", "Cipongkor", "Cikande")
#' y <- c("Tegalwaru", "purwakarta", "Saguling", "Cipongkor", "Cipangeran")
#'
#' get_diff(x, y)
get_diff <- function(x, y) {
  dat <- data.frame(
    x = setdiff(unique(x), unique(y)),
    y = setdiff(unique(y), unique(x))
  )
  cli::cli_h1('Hasil')
  if (nrow(dat) == 0) {
    cli::cli_alert_success(" Tidak ada perbedaan. Yeah... ")
  } else {
    cat(
      stringr::str_glue("x : ada di {crayon::yellow(deparse(substitute(x)))} tidak ada di {crayon::cyan(deparse(substitute(y)))}"),
      stringr::str_glue("y : ada di {crayon::cyan(deparse(substitute(y)))} tidak ada di {crayon::yellow(deparse(substitute(x)))} \n"),
      sep = "\n"
    )
    return(dat)
  }
}
