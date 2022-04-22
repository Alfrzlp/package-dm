style_this <- function(path = rstudioapi::getActiveDocumentContext()$path) {
  rstudioapi::documentClose(path, save = T)
  styler::style_file(path)
  cat(crayon::cyan(crayon::italic("Silahkan pindah ke file lain dan kembali lagi \n")))
  rstudioapi::navigateToFile(path)
}

style_this()

1+1
path <- rstudioapi::getActiveDocumentContext()$path
id <- rstudioapi::documentId()
rstudioapi::document()
