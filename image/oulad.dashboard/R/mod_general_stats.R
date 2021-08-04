#' general_stats UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_general_stats_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        box(
          title = "Study statistics",
          status = "warning",
          width = 12,
          valueBoxOutput(ns("distinction_students"), width = 3),
          valueBoxOutput(ns("pass_students"), width = 3),
          valueBoxOutput(ns("fail_students"), width = 3),
          valueBoxOutput(ns("withdrawn_students"), width = 3)
        )
      )
    )
  )
}
    
#' general_stats Server Function
#'
#' @noRd 
#' @import magrittr
mod_general_stats_server <- function(input, output, session, selected_mod_pres){
  ns <- session$ns

  # select student based on module (reactive value)
  students <- reactive({

    module <- selected_mod_pres$module
    presentation <- selected_mod_pres$presentation
    
    get_connection() %>%
    dplyr::tbl("student_info") %>% 
    dplyr::filter(code_module == module,
                  code_presentation == presentation) %>% 
    dplyr::group_by(final_result) %>% 
    dplyr::count() %>% 
    dplyr::collect() 
  })
  
  # generate box contents from data
  output$distinction_students <-
    renderValueBox({
      students() %>% 
        dplyr::filter(final_result == "Distinction") %>% 
        extract2("n") %>% 
        valueBox("Distinct students",
                 color = "blue")
    })
  
  output$pass_students <-
    renderValueBox({
      students() %>% 
        dplyr::filter(final_result == "Pass") %>% 
        extract2("n") %>% 
        valueBox("Pass students",
                 color = "green")
    })
  
  output$fail_students <-
    renderValueBox({
      students() %>% 
        dplyr::filter(final_result == "Fail") %>% 
        extract2("n") %>% 
        valueBox("Fail students",
                 color = "red")
    })
  
  output$withdrawn_students <-
    renderValueBox({
      students() %>% 
        dplyr::filter(final_result == "Withdrawn") %>% 
        extract2("n") %>% 
        valueBox("Withdrawn students",
                 color = "orange")
    })
 
}
    
## To be copied in the UI
# mod_general_stats_ui("general_stats_ui_1")
    
## To be copied in the server
# callModule(mod_general_stats_server, "general_stats_ui_1")
 
