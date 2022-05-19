#' Setting default conflict ke preferensi saya
#'
#' @param quiet logical
#'
#' @return none
#' @export
#'
#' @examples
#' my_conflict_prefer()
my_conflict_prefer <- function(quiet = TRUE) {
  my_pref <-
    c('filter' = 'dplyr',
      'select' = 'dplyr',
      'slice' = 'dplyr',
      'rename' = 'dplyr')

  cli::cli_h1('Set Deafult')
  for(i in 1:length(my_pref)) {
    conflicted::conflict_prefer(names(my_pref[i]), winner = my_pref[i], quiet = quiet)
    cli::cli_alert_success(cli::style_italic('{my_pref[i]}::{names(my_pref[i])}'))
  }
}
