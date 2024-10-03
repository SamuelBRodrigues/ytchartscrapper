library(tidyverse)

extrai_id <- function(url_estados_cidades_br,time_period = c("2022-06-01/2023-06-30", "2023-06-01/2024-06-30")){
  # This function apply a regex to extract
  extrair_id <- function(texto) {
    regex <- "\\[\"(.*?)\".*?\\{\"id\":\"(.*?)\".*?\"type\":\"(.*?)\""
    
    resultados <- stringr::str_match_all(texto, regex)
    
    df <- purrr::map_dfr(resultados, ~ tibble::tibble(
      termo_busca = .[, 2],
      id = .[, 3],
      tipo = .[, 4]
    ))
    
    df %>%
      dplyr::filter(tipo %in% c("SUBCOUNTRY", "CITY"))
  }
  
  # Built the df with id, query and time period of data extraction
  data <- map_df(time_period,
                 ~extrair_id(url_estados_cidades_br) %>%
                   mutate(validacao = ifelse(tipo == "CITY",
                                             str_detect(termo_busca, "Brazil"),
                                                         "ok")
                          ) %>%
                   filter(validacao != FALSE) %>% 
                   select(-validacao) %>%
                   distinct(id, .keep_all = TRUE) %>%
                   pivot_wider(names_from = tipo,
                               values_from = termo_busca) %>% 
                   mutate(start_end_time = .x)
                 )
  
  if("SUBCOUNTRY" %in% colnames(data)){
    
    data <- data %>% drop_na(SUBCOUNTRY) %>% select(-CITY)
  
  }
  data
}
