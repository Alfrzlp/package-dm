#' Membaca data dari gambar
#'
#' @param path alamat path dari file, default akan membaca dari clipboard
#' @param bahasa bahasa yang digunakan 'eng', 'ind', 'numbers'
#' @param to_df logical, jika TRUE maka output akan langsung berupa data.frame
#' @param ... input untuk fungsi write.table()
#'
#' @return hasil berupa character atau data.frame
#' @export
#'
#' @examples
#' read_img() # membaca dari clipboard
#' read_img('D:/img.jpg', 'numbers')
read_img <- function(path = 'clipboard',
                     bahasa = 'eng', to_df = FALSE, ...){

  tryCatch(
    if(match.arg(path, 'clipboard') == 'clipboard'){
      reticulate::py_run_string('from PIL import ImageGrab')
      reticulate::py_run_string('im = ImageGrab.grabclipboard()')
      reticulate::py_run_string("im.save('D:/text.png', 'PNG')")
    },
    error = function(e) cat('\nClipboard tidak ditemukan. Membaca gambar sebelumnya...\n\n')
  )

  path = 'D:/text.png'
  bahasa <- match.arg(bahasa, c('numbers', 'ind', 'eng'))
  if(bahasa == 'numbers') my_engine <- tesseract::tesseract(options = list(tessedit_char_whitelist = ' .0123456789'))
  else my_engine <- tesseract::tesseract(language = bahasa)

  text <- tesseract::ocr(path, engine = my_engine)

  if(to_df){
    df <- utils::read.table(textConnection(text), header = F)
    utils::write.table(df, "clipboard", sep = "\t", ...)
    return(df)
  }else{
    cat(text)
    utils::writeClipboard(text)
  }
}
