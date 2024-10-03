library(tidyverse)

municipios_alvo <- function(pop = 70000){
  
  # Checa se o arquivo POP2022_Municipios existe
  if(!file.exists("data/POP2022_Municipios_20230622.xls")){
    dir.create("data/")
    download.file("https://ftp.ibge.gov.br/Censos/Censo_Demografico_2022/Previa_da_Populacao/POP2022_Municipios_20230622.xls",
                  destfile = "data/POP2022_Municipios_20230622.xls",
                  mode = "wb")
    
  }
  
  data <- readxl::read_excel("data/POP2022_Municipios_20230622.xls",
                             skip = 1) %>% 
    janitor::clean_names() %>%
    dplyr::mutate(
      #regex to remove all . or brackets values
      populacao = stringr::str_remove_all(populacao, "\\.|\\(.*\\)"),
      populacao = as.numeric(populacao)) %>%
    
    # filtering pop >= 70k
    filter(populacao >= pop) %>% 
    # bring name_state to the dataset
    dplyr::left_join(
      geobr::read_state() %>% 
        dplyr::tibble() %>% 
        dplyr::select(code_state, name_state),
      dplyr::join_by(cod_uf == code_state) 
    ) %>% 
    # create the query for the charts.youtube
    dplyr::mutate(
      query = ifelse(name_state != "Ceará",
                          stringr::str_glue("{nome_do_municipio }, state of {name_state}, Brazil"),
                          stringr::str_glue("{nome_do_municipio }, Ceará, Brazil")),
      query = ifelse(query == "Brasília, state of Distrito Federal, Brazil",
                          "Brasília, Federal District, Brazil",
                          query)
    ) %>% 
    tidyr::unite(cod_ibge,
                 cod_uf,cod_munic,
                 sep = "",
                 remove = FALSE)
  
  cascavel <- data %>% 
    dplyr::filter(nome_do_municipio == "Cascavel") %>% 
    dplyr::first()
  
  data <- dplyr::anti_join(data,cascavel)
}
