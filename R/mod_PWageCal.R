#' PWageCal UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @import stringr
#' @importFrom shiny NS tagList
mod_PWageCal_ui <- function(id){
  ns <- NS(id)
  tagList(
    h3("Professional Wage Calculator Page"),
    shinydashboard::tabBox(
      tags$head(
        tags$style(HTML(" #tabBox {width:90vh,height:100vh !important;}")) #HTML/CSS to help set width of tabBox contents
      ),
      id="pwagetab1",
      width = 12, #This adjusts the tabBox

      #Instructions Panel
      shiny::tabPanel(
        "Instructions",
        h4("Instructions go here...")
      ), #shiny::tabPanel

      #Profression Calculator Panel
      shiny::tabPanel(
        "Profession Wage Calculator",
        fluidRow(
          #Inputs for the Profressional Wages
          shiny::column(
            4,
            h4("Input the following:"),
            shiny::textInput(ns("name"), "Character's Name:", ""),
            shiny::textInput(ns("job"), "Profession:", ""),
            shiny::textInput(ns("gp"), "Base Wage:", ""),
            shiny::textInput(ns("skill"), "Primary Skill:", ""),
            shiny::textInput(ns("location"), "Place of Employment:", ""),
            shiny::selectInput(ns("level"),label="Skill Level:",choices=list("Novice"="novice","Apprentice"="apprentice",
                                                                  "Journeyman"="journeyman","Expert"="expert",
                                                                  "Master"="master")),
            shiny::textInput(ns("loyal"), "Number of Seasons at Job:", ""),
            shiny::selectInput(ns("season"),label="Season:",choices=list("Glade"="glade","Searing"="searing",
                                                              "Ash"="ash","Frost"="frost")),
            shiny::textInput(ns("jt1"), "Job Thread 1:", ""),
            shiny::textInput(ns("jt2"), "Job Thread 2:", "")
          ),

          #Display Seasonal Wages
          shiny::column(
            8,
            h4("Seasonal Wage"),
            div(id="form",verbatimTextOutput(ns("txtout"),placeholder = TRUE)), #Generated from the server

            actionButton(ns("button"),"Submit")

          )
        ) #fluidRow

      ) #shiny::tabPanel

    ) #shinydashboard::tabBox


  ) #taglist
}

#' PWageCal Server Functions
#'
#' @noRd
mod_PWageCal_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    observeEvent(input$button,{
      output$txtout<-renderText({

        #Get players name
        isolate(pname<-input$name)

        #Get job
        isolate(pjob<-input$job)

        #Get place of employement
        isolate(employer<-input$location)

        #get base wage
        isolate(bwage<-as.numeric(input$gp))

        #Get primary skill
        isolate(pskill<-input$skill)

        #Adjusted wage
        isolate(
          if(input$level=="apprentice"){
            awage<-ceiling(bwage*1.5)
          }else
            if(input$level=="journeyman"){
              awage<-ceiling(bwage*1.5*2)
            }else
              if(input$level=="expert"){
                awage<-ceiling(bwage*1.5*2*2.5)
              }else
                if(input$level=="master"){
                  awage<-ceiling(bwage*1.5*2*2.5*3)
                }else{
                  awage<-ceiling(bwage*1)
                })



        #Get loyalty bonus
        isolate(
          if(input$loyal<2){
            lbonus<-0
          }else
            if(input$loyal==2){
              lbonus<-.01
            }else
              if (input$loyal==3){
                lbonus<-.02
              }else
                if (input$loyal==4){
                  lbonus<-.03
                }else
                  if (input$loyal==5){
                    lbonus<-.04
                  }else {
                    lbonus<-.05
                  })

        #Get days of the season
        isolate(
          if(input$season=="glade"){
            days<-92
          }else{
            days<-91
          })

        #Calculate Wage
        isolate(
          wage<-awage*days)

        #Calculate seasons wage
        isolate(
          seasonwage<-wage+(wage*lbonus)
        )

        #paste(pname,pjob,bwage,pskill,awage,lbonus,days,seasonwage)


        paste(

          "[style=margin: 20px auto 20px auto; max-width: 700px; padding: 5px 30px 10px 30px; border-top: double 6px #000000; border-right: double 6px #000000; border-bottom: double 6px #000000; border-left: double 6px #000000; border-radius: 3px; background-color: #000000; background-image: url(https://i.imgur.com/yqdxU61.png)]
[style2=margin: auto; max-width: 700px; padding: 35px 0px 30px 0px; color: #000000; text-align: justify; font-size: 108%]
[size=200][center][googlefont=Cormorant SC]",stringr::str_to_title(input$season),"Wages[/center][/size][/googlefont]

\n[list][*] [b]Name:[/b]",pname,
          "\n[*] [b]Profession:[/b]",pjob,
          "\n[*][b]Base Wage:[/b]",bwage,"gp",
          "\n[*] [b]Primary Profession Skill:[/b]",pskill,
          "\n[*] [b]Level of Mastery:[/b]",str_to_title(input$level),
          "\n[*] [b]Location of Employment:[/b]",employer,
          "\n[*] [b]Wages for the Season:[/b]",seasonwage,"gp",
          "\n[*] [b]Job Thread 1:[/b]",input$jt1,
          "\n[*] [b]Job Thread 2:[/b]",input$jt2,"[/list]

\n[code]
\n[list][*] [b]Name:[/b]",pname,
          "\n[*] [b]Profession:[/b]",pjob,
          "\n[*][b]Base Wage:[/b]",bwage,"gp",
          "\n[*] [b]Wages for the Season:[/b]",seasonwage,"gp",
          "\n[*] [b]Primary Profession Skill:[/b]",pskill,
          "\n[*] [b]Level of Mastery:[/b]",str_to_title(input$level),
          "\n[*] [b]Location of Employment:[/b]",employer,
          "\n[*] [b]Job Thread 1:[/b]",input$jt1,
          "\n[*] [b]Job Thread 2:[/b]",input$jt2,
          "\n[/list][/code]
\n[/style2][/style]"

        )




      })
    })

  })
}

## To be copied in the UI
# mod_PWageCal_ui("PWageCal_1")

## To be copied in the server
# mod_PWageCal_server("PWageCal_1")
