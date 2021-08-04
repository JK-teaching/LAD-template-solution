#' Inverted versions of in, is.null and is.na
#' 
#' @noRd
#' 
#' @examples
#' 1 %not_in% 1:10
#' not_null(NULL)
`%not_in%` <- Negate(`%in%`)

not_null <- Negate(is.null)

not_na <- Negate(is.na)

#' Removes the null from a vector
#' 
#' @noRd
#' 
#' @example 
#' drop_nulls(list(1, NULL, 2))
drop_nulls <- function(x){
  x[!sapply(x, is.null)]
}

#' If x is `NULL`, return y, otherwise return x
#' 
#' @param x,y Two elements to test, one potentially `NULL`
#' 
#' @noRd
#' 
#' @examples
#' NULL %||% 1
"%||%" <- function(x, y){
  if (is.null(x)) {
    y
  } else {
    x
  }
}

#' If x is `NA`, return y, otherwise return x
#' 
#' @param x,y Two elements to test, one potentially `NA`
#' 
#' @noRd
#' 
#' @examples
#' NA %||% 1
"%|NA|%" <- function(x, y){
  if (is.na(x)) {
    y
  } else {
    x
  }
}

#' Typing reactiveValues is too long
#' 
#' @inheritParams reactiveValues
#' @inheritParams reactiveValuesToList
#' 
#' @noRd
rv <- shiny::reactiveValues
rvtl <- shiny::reactiveValuesToList

#' Database connection
#' 
#' @noRd
conn_env <- new.env()

get_connection <- function(){
  
  # create connection only once and store it in helper environment
  if(!exists("connection", envir = conn_env)) {
    conn_env$connection <-DBI::dbConnect(RMariaDB::MariaDB(),
                                         host = get_golem_config("analytics_db_host"),
                                         port = get_golem_config("analytics_db_port"),
                                         dbname = get_golem_config("analytics_db_name"),
                                         user = get_golem_config("analytics_db_user"),
                                         password = get_golem_config("analytics_db_pass"))
  }
  
  conn_env$connection
  
}

#' Module presentation list
#' 
#' @noRd
get_module_presentations <- function(){
  get_connection() %>% 
    dplyr::tbl("courses") %>% 
    dplyr::select(code_module, code_presentation) %>% 
    dplyr::collect() %>% 
    dplyr::mutate(module_presentation = stringr::str_c(code_module, code_presentation,sep = "/")) %>% 
    magrittr::extract2("module_presentation")
}
