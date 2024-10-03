#' Extract Songs from YouTube Charts Data
#'
#' This function extracts song information from the YouTube Charts data.
#'
#' @param data The dataset containing YouTube Charts data.
#'
#' @return A data frame with song information.
#'
#' @examples
#' \dontrun{
#'   song_data <- extrai_musicas(data)
#' }
#' @export

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
        dplyr::tibble(data = .) %>%
        tidyr::unnest_wider(data) %>%
        tidyr::unnest_longer(trackViews) %>%
        tidyr::unnest_wider(trackViews) %>%
        dplyr::mutate(city = cidade,
               "date_start/date_end" = date_start_end,
               thumbnail = thumbnails,
               viewCount = viewCount %>% as.numeric())

      rbind(artista)
    }

    data <- purrr::map_df(seq(1:length(dados_yt_charts)),
                   ~ extrai_musica(data = dados_yt_charts, x = .x)) %>%
      dplyr::left_join(
        alvo %>%
          dplyr::select(uf,cod_uf,cod_ibge,nome_do_municipio),
        by = dplyr::join_by(city == nome_do_municipio)
      ) %>%
      tidyr::unnest_longer(artists) %>%
      tidyr::unnest_longer(artists) %>%
      dplyr::filter(row_number() %% 2 == 0)

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
        dplyr::tibble(data = .) %>%
        tidyr::unnest_wider(data) %>%
        tidyr::unnest_longer(trackViews) %>%
        tidyr::unnest_wider(trackViews) %>%
        dplyr::mutate(city = cidade,
               "date_start/date_end" = date_start_end,
               thumbnail = thumbnails,
               viewCount = viewCount %>% as.numeric())

      rbind(artista)
    }

    data <- purrr::map_df(seq(1:length(dados_yt_charts)),
                   ~ extrai_musica(data = dados_yt_charts, x = .x)) %>%
      dplyr::left_join(alvo %>%  dplyr::select(-query),
                by = dplyr::join_by(city == name_state)
      ) %>%
      tidyr::unnest_longer(artists) %>%
      tidyr::unnest_longer(artists) %>%
      dplyr::filter(row_number() %% 2 == 0)

  }
  data
}

