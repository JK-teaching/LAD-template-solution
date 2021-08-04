#' activity_graph UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_activity_graph_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        box(
          title = "VLE activity",
          status = "primary",
          width = 12,
          plotOutput(ns("vle_activity_plot"))
        )
      )
    )
  )
}
    
#' activity_graph Server Function
#'
#' @noRd 
#' @import magrittr
mod_activity_graph_server <- function(input, output, session, selected_mod_pres){
  ns <- session$ns

  # generate graph (renderPlot is reactive)
  output$vle_activity_plot <-
    renderPlot({
      
      module <- selected_mod_pres$module
      presentation <- selected_mod_pres$presentation
      
      # get data for plot
      data <- 
      get_connection() %>% 
        dplyr::tbl("student_vle") %>% 
        dplyr::filter(code_module == module, 
                      code_presentation == presentation) %>% 
        dplyr::mutate(week = floor((date+1)/7)) %>% 
        dplyr::group_by(id_student, week) %>% 
        dplyr::summarise(sum_click = sum(sum_click, na.rm = TRUE)) %>% 
        dplyr::group_by(week) %>% 
        dplyr::summarise(sum_click = mean(sum_click, na.rm = TRUE)) %>% 
        dplyr::select(week, sum_click) %>% 
        dplyr::collect() %>%
        dplyr::mutate(week = as.numeric(week)) 
      
      # make plot via ggplot2
      data %>% 
        ggplot2::ggplot(ggplot2::aes(x = week, y = sum_click)) +
        ggplot2::geom_line(color = "#00696e", size = 2) +
        ggplot2::labs(x = "Date [weeks]", y = "Average clicks") +
        ggplot2::theme_classic() +
        ggplot2::scale_x_continuous(expand = c(0,0), breaks = seq(min(data$week),max(data$week))) +
        ggplot2::scale_y_continuous(expand = c(0,100))
    })
 
}
    
## To be copied in the UI
# mod_activity_graph_ui("activity_graph_ui_1")
    
## To be copied in the server
# callModule(mod_activity_graph_server, "activity_graph_ui_1")
 
