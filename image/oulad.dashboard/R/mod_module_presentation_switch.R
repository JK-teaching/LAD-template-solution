#' module_presentation_switch UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_module_presentation_switch_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        box(
          title = "Course selection",
          status = "info",
          width = 12,
          selectInput(ns("module_presentation_select"),
                      "Please select module/presentation:",
                      get_module_presentations()),
          textOutput(ns("text"))
        )
      )
    )
 
  )
}
    
#' module_presentation_switch Server Function
#'
#' @noRd 
mod_module_presentation_switch_server <- function(input, output, session){
  ns <- session$ns

  # define reactive values of module and presentation
  to_return <- reactiveValues(module = "AAA", presentation = "2014J")
  
  # observe change event on the selectInput and assign reactive values
  observeEvent(input$module_presentation_select,
               {
                 to_return$module <- stringr::str_split(input$module_presentation_select,"/")[[1]][1]
                 to_return$presentation <- stringr::str_split(input$module_presentation_select,"/")[[1]][2]
               })
  
  # return the reactive values
  to_return
}

## To be copied in the UI
# mod_module_presentation_switch_ui("module_presentation_switch_ui_1")
    
## To be copied in the server
# callModule(mod_module_presentation_switch_server, "module_presentation_switch_ui_1")
 
