#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

  #Profession Wage Logic
  mod_PWageCal_server("PWageCal_1")

  #Business Wage Logic
  mod_BWageCal_server("BWageCal_1")
}
