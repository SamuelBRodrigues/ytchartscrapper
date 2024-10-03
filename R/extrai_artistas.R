#' Extract Artists from YouTube Charts Data
#'
#' This function extracts artist information from the YouTube Charts data.
#'
#' @param data The dataset containing YouTube Charts data.
#'
#' @return A data frame with artist information.
#'
#' @examples
#' \dontrun{
#'   artist_data <- extrai_artistas(data)
#' }
#' @export

extrai_artistas <- function(dados_yt_charts, alvo){

  # Para Cidades ---------------------------------------------------------------
  if("nome_do_municipio" %in% colnames(alvo)){

    extrai_artista <- function(data, x){

      # Extraindo a cidade
      cidade <- data[[x]][["contents"]]$sectionListRenderer$contents[[1]]$musicAnalyticsSectionRenderer$content$perspectiveMetadata[[1]]

      # Extraindo data
      date_start <- data[[x]][["contents"]][["sectionListRenderer"]][["contents"]][[1]][["musicAnalyticsSectionRenderer"]][["content"]][["perspectiveMetadata"]][["requestParams"]][["dateParams"]][["startTime"]] %>%
        stringr::str_extract("\\S{10}")
      date_end <- data[[x]][["contents"]][["sectionListRenderer"]][["contents"]][[1]][["musicAnalyticsSectionRenderer"]][["content"]][["perspectiveMetadata"]][["requestParams"]][["dateParams"]][["endTime"]] %>%
        stringr::str_extract("\\S{10}")
      date_start_end <- stringr::str_glue("{date_start}/{date_end}")

      # Extraindo top artistas
      artista <- data[[x]][["contents"]]$sectionListRenderer$contents[[1]]$musicAnalyticsSectionRenderer$content$artists %>%
        dplyr::tibble(data = .) %>%
        tidyr::unnest_wider(data) %>%
        tidyr::unnest_longer(artistViews) %>%
        tidyr::unnest_wider(artistViews) %>%
        dplyr::mutate(city = cidade,
               "date_start/date_end" = date_start_end,
               thumbnail = thumbnail %>% unlist(),
               viewCount = viewCount %>% as.numeric())

      rbind(artista)
    }

    data <- purrr::map_df(seq(1:length(dados_yt_charts)),
                   ~ extrai_artista(data = dados_yt_charts, x = .x)) %>%
      dplyr::left_join(
        alvo %>%
          dplyr::select(uf,cod_uf,cod_ibge,nome_do_municipio),
        by = dplyr::join_by(city == nome_do_municipio)
      )

  }

  # Para Estados ---------------------------------------------------------------
  if(!("nome_do_municipio" %in% colnames(alvo))){

    extrai_artista <- function(data, x){

      # Extraindo a cidade
      cidade <- data[[x]][["contents"]]$sectionListRenderer$contents[[1]]$musicAnalyticsSectionRenderer$content$perspectiveMetadata[[1]]

      # Extraindo data
      date_start <- data[[x]][["contents"]][["sectionListRenderer"]][["contents"]][[1]][["musicAnalyticsSectionRenderer"]][["content"]][["perspectiveMetadata"]][["requestParams"]][["dateParams"]][["startTime"]] %>%
        stringr::str_extract("\\S{10}")
      date_end <- data[[x]][["contents"]][["sectionListRenderer"]][["contents"]][[1]][["musicAnalyticsSectionRenderer"]][["content"]][["perspectiveMetadata"]][["requestParams"]][["dateParams"]][["endTime"]] %>%
        stringr::str_extract("\\S{10}")
      date_start_end <- stringr::str_glue("{date_start}/{date_end}")

      # Extraindo top artistas
      artista <- data[[x]][["contents"]]$sectionListRenderer$contents[[1]]$musicAnalyticsSectionRenderer$content$artists %>%
        dplyr::tibble(data = .) %>%
        tidyr::unnest_wider(data) %>%
        tidyr::unnest_longer(artistViews) %>%
        tidyr::unnest_wider(artistViews) %>%
        dplyr::mutate(city = cidade,
               "date_start/date_end" = date_start_end,
               thumbnail = thumbnail %>% unlist(),
               viewCount = viewCount %>% as.numeric())

      rbind(artista)
    }

    data <- purrr::map_df(seq(1:length(dados_yt_charts)),
                   ~ extrai_artista(data = dados_yt_charts, x = .x)) %>%
      dplyr::left_join(alvo %>% dplyr::select(-query),
                by = dplyr::join_by(city == name_state)
      )

  }
  data
}

