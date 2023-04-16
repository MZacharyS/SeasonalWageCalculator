#' BWageCal UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_BWageCal_ui <- function(id){
  ns <- NS(id)
  tagList(

    h3("Business Wage Calculator Page"),

    shinydashboard::tabBox(
      tags$head(
        tags$style(HTML(" #tabBox {width:90vh !important;}")) #HTML/CSS to help set width of tabBox contents
      ),
      id="bwagetab1",
      width = 12, #This adjusts the tabBox

      #Instructions Panel
      shiny::tabPanel(
        "Instructions",
        h4("Instructions go here...")
      ), #shiny::tabPanel

      #Profression Calculator Panel
      shiny::tabPanel(
        "Business Wage Calculator",
        h4("Calculator goes here...")
      ) #shiny::tabPanel

    ) #shinydashboard::tabBox


  )
}

#' BWageCal Server Functions
#'
#' @noRd
mod_BWageCal_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_BWageCal_ui("BWageCal_1")

## To be copied in the server
# mod_BWageCal_server("BWageCal_1")
