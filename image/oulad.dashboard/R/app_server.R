#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # List the first level callModules here
  # retrieve the selected module presentation from switch shiny mod
  selected_mod_pres <- callModule(mod_module_presentation_switch_server, "module_presentation_switch_ui_1")
  # call other modules with the reactive values from mod_pres switcher as an argument
  callModule(mod_general_stats_server, "general_stats_ui_1", selected_mod_pres)
  callModule(mod_activity_graph_server, "activity_graph_ui_1", selected_mod_pres)
  callModule(mod_student_overview_server, "student_overview_ui_1", selected_mod_pres)
}
