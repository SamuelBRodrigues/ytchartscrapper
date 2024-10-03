#' Target States for YouTube Charts Data Extraction
#'
#' This function provides a list of target states for which YouTube charts data should be extracted.
#'
#' @return A vector of state names or codes.
#'
#' @examples
#' \dontrun{estados_alvo()}
#' @export
estados_alvo <- function(){

  # Checa se o arquivo POP2022_Municipios existe
  if(!file.exists("data/POP2022_Municipios_20230622.xls")){
    dir.create("data/")
    download.file("https://ftp.ibge.gov.br/Censos/Censo_Demografico_2022/Previa_da_Populacao/POP2022_Municipios_20230622.xls",
                  destfile = "data/POP2022_Municipios_20230622.xls",
                  mode = "wb")

  }

  data <- geobr::read_state() %>%
    dplyr::tibble() %>%
    dplyr::select(code_state, abbrev_state, name_state) %>%
    # create the query for the charts.youtube
    dplyr::mutate(
      query = ifelse(name_state != "Ceará",
                     stringr::str_glue("state of {name_state}, Brazil"),
                     stringr::str_glue("Ceará, Brazil")),
      query = case_match(query,
                         "state of Distrito Federal, Brazil" ~ "Federal District, Brazil",
                         .default = query)
    )
  readr::write_rds(data,"data/estados_alvo.rds")
  data
}
