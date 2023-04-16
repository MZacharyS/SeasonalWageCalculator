#' The application User-Interface
#' #Created 04/15/2023 by Zac Smith for legendsofransera.com
#' Adding another line to confirm repository works
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' @import shinydashboardPlus
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),

    # Your application UI logic
    # fluidPage(
      shinydashboardPlus::dashboardPage(
        # skin = "midnight",
        header=shinydashboardPlus::dashboardHeader(
          title = "Wage Calculator"
          # enable_rightsidebar=FALSE
        ), #dashboardHeaderPlus

        #Navigation Menu
        sidebar = shinydashboard::dashboardSidebar(

          ##The Menus - The tabName is what is used to display the correct information
          shinydashboard::sidebarMenu(
            id = "tabs",

            ###Profession Wage Calculator Page
            shinydashboard::menuItem("Profession Wage Calcuator", tabName="pwage",icon = icon("user-tie")),

            ###Business Wage Calculator Page
            shinydashboard::menuItem("Business Wage Calculator", tabName="bwage",icon = icon("building"))
          )


        ), #dashboardSidebar

        #Body of tabs that shows the calculators/information
        body = shinydashboard::dashboardBody(

          ##The tabs created in the Navigation Menu get called/filled out here
          shinydashboard::tabItems(

            ###Professional Wage Calculator Page
            shinydashboard::tabItem("pwage",mod_PWageCal_ui("PWageCal_1")),

            ###Business Wage Calculator Page
            shinydashboard::tabItem("bwage",mod_BWageCal_ui("BWageCal_1"))
          ) #tabItems
        ), #dashboardBody

        controlbar = shinydashboardPlus::dashboardControlbar(
          collapsed = TRUE,
          shinydashboardPlus::skinSelector()
        )






      ) #dashboardPagePlus - Keep tags within this parenthesis
    # ) #Fluid Page
  ) #tagList
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "SeasonalWageCalculator"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
