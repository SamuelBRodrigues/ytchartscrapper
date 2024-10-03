library(tidyverse)


extrai_musicas <- function(dados_yt_charts, alvo){
  
  # Para Cidades ---------------------------------------------------------------
  if("nome_do_municipio" %in% colnames(alvo)){
    
    extrai_musica <- function(data, x){
      
      # Extraindo a cidade
      cidade <- data[[x]][["contents"]]$sectionListRenderer$contents[[1]]$musicAnalyticsSectionRenderer$content$perspectiveMetadata[[1]]
      
      # Extraindo a thumbnail
      thumbnails <- data[[x]][["contents"]][["sectionListRenderer"]][["contents"]][[1]][["musicAnalyticsSectionRenderer"]][["content"]][["trackTypes"]][[1]][["trackViews"]][[1]][["thumbnail"]][["thumbnails"]][[1]][["url"]]
      
      # Extraindo data
      date_start <- data[[x]][["contents"]][["sectionListRenderer"]][["contents"]][[1]][["musicAnalyticsSectionRenderer"]][["content"]][["perspectiveMetadata"]][["requestParams"]][["dateParams"]][["startTime"]] %>% 
        stringr::str_extract("\\S{10}")
      date_end <- data[[x]][["contents"]][["sectionListRenderer"]][["contents"]][[1]][["musicAnalyticsSectionRenderer"]][["content"]][["perspectiveMetadata"]][["requestParams"]][["dateParams"]][["endTime"]] %>% 
        stringr::str_extract("\\S{10}")
      date_start_end <- stringr::str_glue("{date_start}/{date_end}")
      
      # Extraindo top artistas
      artista <- data[[x]][["contents"]]$sectionListRenderer$contents[[1]]$musicAnalyticsSectionRenderer$content$trackTypes %>%
        tibble(data = .) %>% 
        unnest_wider(data) %>% 
        unnest_longer(trackViews) %>% 
        unnest_wider(trackViews) %>% 
        mutate(city = cidade,
               "date_start/date_end" = date_start_end,
               thumbnail = thumbnails,
               viewCount = viewCount %>% as.numeric())
      
      rbind(artista)
    }
    
    data <- map_df(seq(1:length(dados_yt_charts)),
                   ~ extrai_musica(data = dados_yt_charts, x = .x)) %>% 
      left_join(
        alvo %>% 
          select(uf,cod_uf,cod_ibge,nome_do_municipio),
        by = join_by(city == nome_do_municipio)
      ) %>%
      unnest_longer(artists) %>% 
      unnest_longer(artists) %>% 
      filter(row_number() %% 2 == 0)
    
  }
  
  # Para Estados ---------------------------------------------------------------
  if(!("nome_do_municipio" %in% colnames(alvo))){
    
    extrai_musica <- function(data, x){
      
      # Extraindo a cidade
      cidade <- data[[x]][["contents"]]$sectionListRenderer$contents[[1]]$musicAnalyticsSectionRenderer$content$perspectiveMetadata[[1]]
      
      # Extraindo a thumbnail
      thumbnails <- data[[x]][["contents"]][["sectionListRenderer"]][["contents"]][[1]][["musicAnalyticsSectionRenderer"]][["content"]][["trackTypes"]][[1]][["trackViews"]][[1]][["thumbnail"]][["thumbnails"]][[1]][["url"]]
      
      # Extraindo data
      date_start <- data[[x]][["contents"]][["sectionListRenderer"]][["contents"]][[1]][["musicAnalyticsSectionRenderer"]][["content"]][["perspectiveMetadata"]][["requestParams"]][["dateParams"]][["startTime"]] %>% 
        stringr::str_extract("\\S{10}")
      date_end <- data[[x]][["contents"]][["sectionListRenderer"]][["contents"]][[1]][["musicAnalyticsSectionRenderer"]][["content"]][["perspectiveMetadata"]][["requestParams"]][["dateParams"]][["endTime"]] %>% 
        stringr::str_extract("\\S{10}")
      date_start_end <- stringr::str_glue("{date_start}/{date_end}")
      
      # Extraindo top artistas
      artista <- data[[x]][["contents"]]$sectionListRenderer$contents[[1]]$musicAnalyticsSectionRenderer$content$trackTypes %>%
        tibble(data = .) %>% 
        unnest_wider(data) %>% 
        unnest_longer(trackViews) %>% 
        unnest_wider(trackViews) %>% 
        mutate(city = cidade,
               "date_start/date_end" = date_start_end,
               thumbnail = thumbnails,
               viewCount = viewCount %>% as.numeric())
      
      rbind(artista)
    }
    
    data <- map_df(seq(1:length(dados_yt_charts)),
                   ~ extrai_musica(data = dados_yt_charts, x = .x)) %>% 
      left_join(alvo %>%  select(-query),
                by = join_by(city == name_state)
      ) %>%
      unnest_longer(artists) %>% 
      unnest_longer(artists) %>% 
      filter(row_number() %% 2 == 0)
    
  }
  data
}

