#' BWageCal UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @import DT
#' @import tibble
#' @importFrom shiny NS tagList
mod_BWageCal_ui <- function(id){
  ns <- NS(id)
  tagList(

    h3("Business Wage Calculator Page"),

    shinydashboard::tabBox(
      tags$head(
        tags$style(HTML(" #tabBox {width:80vh !important;}")) #HTML/CSS to help set width of tabBox contents
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
        fluidRow(
          shiny::column(
            5, align="center",
            h3("Business Information Table"),
            DTOutput(ns("bwagetable")),
            HTML("<br><br><br>"),
            actionButton(ns("tablebutton"),label = "Submit Business Information")
          ), #Business Wage Table Column

          shiny::column(
            7, align="center",
            h3("Employee Information Table"),
            DTOutput(ns("employeetable"))
          ) #Employee Table Column
        ) #fluidRow
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

    #Create Business Wage Table for Inputs
    bwtable<-reactiveValues(
      data = {
        # data.frame(x = numeric(0), y=numeric(0))%>%
        #   add_row(x = rep(0,10),y=rep(0,10))

        data.frame(
          `Business Information` = c("Season","Year","PC Name","Character Sheet","Business Sheet",
                                     "Ingenuity Bonus","Seasons in Business","Base Wage","Primary Skill",
                                     "Primary Skill Rank","Secondary Skill", "Secondary Skill Rank",
                                     "Tertiary Skill","Tertiary Skill Rank","Job Thread 1","Job Thread 2",
                                     "Job Thread 3"),
          `Input` = NA
        )
      }
    )

    eptable<-reactiveValues(
      data = {
        # data.frame(x = numeric(0), y=numeric(0))%>%
        #   add_row(x = rep(0,10),y=rep(0,10))

        data.frame(
          "Employee Name"=rep(NA,17),
          "Employee Type (PC/NPC)"=rep(NA,17),
          "Base Wage"=rep(NA,17),
          "Skill Rank"=rep(NA,17)
        )
      }
    )

    #Output editable data table
    output$bwagetable<-renderDT({
      DT::datatable(bwtable$data, editable=TRUE,
                    options = list(dom= "ft",
                                   pageLength = 25))
    })

    output$employeetable<-renderDT({
      DT::datatable(eptable$data, editable=TRUE,
                    options = list(dom= "ft",
                                   pageLength = 25))
    })

  })
}

## To be copied in the UI
# mod_BWageCal_ui("BWageCal_1")

## To be copied in the server
# mod_BWageCal_server("BWageCal_1")
