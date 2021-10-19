#' Merubah string menjadi vektor
#'
#' @param str string
#' @param pemisah character pemisah antar nilai
#'
#' @return vector
#' @export
#'
#' @examples
#' str2vec('1.2 3.4 5 9 100')
#' str2vec('1.2, 3.4, 5, 9, 100', pemisah = '\\,')

str2vec <- function (str, pemisah = " "){
    str = gsub(",", ".", str)
    str = gsub(paste0(pemisah, "|\t|\n"), " ", str)
    str = strsplit(str, split = " ")[[1]]
    vec = as.numeric(str[stringr::str_detect(str, "[:alnum:]")])
    return(vec)
  }
