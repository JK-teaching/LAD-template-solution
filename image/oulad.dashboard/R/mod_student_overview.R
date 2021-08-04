#' student_overview UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_student_overview_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        box(
          title = "Students",
          status = "success",
          width = 12,
          DT::dataTableOutput(ns("student_overview_table"))
        )
      )
    )
  )
}
    
#' student_overview Server Function
#'
#' @noRd 
#' @import magrittr
mod_student_overview_server <- function(input, output, session, selected_mod_pres){
  ns <- session$ns
  
  # render table with students (renderDataTable is reactive component)
  output$student_overview_table <-
    DT::renderDataTable({
      module <- selected_mod_pres$module
      presentation <- selected_mod_pres$presentation
      
      # get student list
      students <-
        get_connection() %>% 
        dplyr::tbl("student_info") %>% 
        dplyr::filter(code_module == module,
                      code_presentation == presentation) %>% 
        dplyr::select(id_student,gender, region, highest_education, final_result) %>% 
        dplyr::collect()
      
      # get assessment list
      assessments <- 
        get_connection() %>% 
        dplyr::tbl("assessments") %>% 
        dplyr::filter(code_module == module, 
                      code_presentation == presentation, 
                      assessment_type == "TMA")
      
      # get student results in the assessments
      results <- 
        get_connection() %>% 
        dplyr::tbl("student_assessment") %>% 
        dplyr::inner_join(assessments, by = "id_assessment") %>% 
        dplyr::arrange(id_student,id_assessment) %>% 
        dplyr::group_by(id_student) %>% 
        dplyr::collect() %>% 
        dplyr::mutate(results = stringr::str_c(score,collapse = ", ")) %>% 
        dplyr::select(id_student, results)
      
      # join all data and create contents of the table
      students %>% 
        dplyr::inner_join(results, by = "id_student") %>% 
        dplyr::select(id_student,gender, region, highest_education, results, final_result) %>% 
        dplyr::distinct()
        
        
    },
    rownames = FALSE,
    selection = "none",
    options = list(dom = 'tp'))
 
}
    
## To be copied in the UI
# mod_student_overview_ui("student_overview_ui_1")
    
## To be copied in the server
# callModule(mod_student_overview_server, "student_overview_ui_1")
 
