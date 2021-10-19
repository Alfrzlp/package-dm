#' Merubah string menjadi vektor
#'
#' @param str string
#' @param sep character pemisah antar nilai seperti koma dll
#'
#' @return vector
#' @export
#'
#' @examples
#' str2vec('1.2 3.4 5 9 100')
#' str2vec('1.2, 3.4, 5, 9, 100', sep = '\\,')

str2vec <- function (str, sep = " "){
    str = gsub(",", ".", str)
    str = gsub(paste0(pemisah, "|\t|\n"), " ", str)
    str = strsplit(str, split = " ")[[1]]
    vec = as.numeric(str[stringr::str_detect(str, "[:alnum:]")])
    return(vec)
  }
