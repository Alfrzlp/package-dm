str2vec <- function (str, pemisah = " "){
    str = gsub(",", ".", str)
    str = gsub(paste0(pemisah, "|\t|\n"), " ", str)
    str = strsplit(str, split = " ")[[1]]
    vec = as.numeric(str[stringr::str_detect(str, "[:alnum:]")])
    return(vec)
  }
