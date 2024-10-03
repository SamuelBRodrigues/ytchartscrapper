library(tidyverse)

dados_yt_charts <- function(id, time_period){
  
  data <- map2(id,
               time_period,
               ~{
                 codigo_cidade <- .x
                          
                 Sys.sleep(runif(1, 1,3))
                          
                 httr2::request("https://charts.youtube.com/youtubei/v1/browse") |> 
                   httr2::req_url_query(
                     alt = "json",
                     key = "AIzaSyCzEW7JUJdSql0-2V4tHUb6laYm4iAE_dM",
                   ) |> 
                   httr2::req_headers(
                     accept = "*/*",
                     `accept-language` = "pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7",
                     authorization = "SAPISIDHASH 1725822503_9e3de5a13215d745891f777335eff74c69e56144",
                     `content-type` = "application/json",
                     cookie = "YSC=76j6z0CNM3Y; VISITOR_INFO1_LIVE=dH_q3VrNvpA; VISITOR_PRIVACY_METADATA=CgJCUhIEGgAgWw%3D%3D; LOGIN_INFO=AFmmF2swRQIhAPg5kW5LjgOFdWhMfXHkGKlTpZoLS6npAB5cVcUk5hzVAiBZdAowlhHhDbdkyS83HqfNxpbfzdDZDWi7QnbiS0RTdw:QUQ3MjNmeEtZU1B0cG5iNUdidkJsNWlVbUppc3dKVEJ0cjA0QUtSbjl0QXNBSTdXNmlGYkFGSktES0EtMUxUX0lCWktidGsyVmVLa1FKQjZ6YkphbDhSN1M0RS15R2tWajBOMC00N3FxY050SURqaVFXZUJQcTNtMW5FTEVWVzctb3NDNXdhUV82b2hVOG9XWVhIVk1ESUliUkhNMjdIV0lB; S=youtube_lounge_remote=J0mJ1mfTrNyrNfIpa8xPcoh1gs7bSJMXSKolSfDr86w; _ga=GA1.1.1482384324.1724800469; SID=g.a000ngiMlDXSXNG54-yLKlE_8nb54Ch-DOqBYurLae5-c-m_ty619a0TjWis4XinU19LHI-UMQACgYKAZISARUSFQHGX2Mitjg2EqIg3aEqS4N6uK0Y6RoVAUF8yKrc1fAwF9sZEDnddxMO5SPs0076; __Secure-1PSID=g.a000ngiMlDXSXNG54-yLKlE_8nb54Ch-DOqBYurLae5-c-m_ty61ZoA3df3LTADBFb6pNJgL7wACgYKAWkSARUSFQHGX2MiKDbDIum5iMjKJgq4og7H4RoVAUF8yKpQvJ-pw5x6JJKxdtzzcGPd0076; __Secure-3PSID=g.a000ngiMlDXSXNG54-yLKlE_8nb54Ch-DOqBYurLae5-c-m_ty61dzBgz7_Sn3zCX0oNSbDI1QACgYKAUwSARUSFQHGX2MiVOkQ8FKZbqIEcg_Gg-RatRoVAUF8yKrjc-Qmo-i6YzoCpEFfdO5r0076; HSID=AY4IxgcJBIzkiES7O; SSID=AsU8_JsRN_OA2Cl1W; APISID=oqlv7svYIySS-R2s/AEf9Ns1fCGczaGV5E; SAPISID=bHDlVXpChTl7KRiV/A5oqnWw0qltg569CF; __Secure-1PAPISID=bHDlVXpChTl7KRiV/A5oqnWw0qltg569CF; __Secure-3PAPISID=bHDlVXpChTl7KRiV/A5oqnWw0qltg569CF; PREF=f6=40000000&tz=America.Fortaleza&f7=100; __Secure-1PSIDTS=sidts-CjIBUFGoh86PSwdKQ0saHSLVj9p6TVI26lI9Nmq-AfBgymJktBp0gkeRSE8kGrO9T9WyMhAA; __Secure-3PSIDTS=sidts-CjIBUFGoh86PSwdKQ0saHSLVj9p6TVI26lI9Nmq-AfBgymJktBp0gkeRSE8kGrO9T9WyMhAA; _ga_2LYFVQK29H=GS1.1.1725821087.10.1.1725822310.0.0.0; SIDCC=AKEyXzWxvlw-yppMb2kG95_HLkTLCcX10NC_mcbnqzh8S-G36RPBSxByVAqb5s9DE32IHYJq0w; __Secure-1PSIDCC=AKEyXzWsitHENfedkEUoBkS5k-zXm0Ct8geg4FWqmCbI2SguPYXc2RNjzPk9zhwuYfqfVCStJHs; __Secure-3PSIDCC=AKEyXzVN7LqdAU9IluHh7jtcW_T4iQF26b8QPhoVNgBfK-Wv6kQd05-29VJ7i76G_9dwNGGq9w",
                     origin = "https://charts.youtube.com",
                     priority = "u=1, i",
                     `user-agent` = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 OPR/112.0.0.0",
                     `x-client-data` = "CMqGywE=",
                     `x-goog-authuser` = "0",
                     `x-goog-visitor-id` = "CgtYRWljR29lZ3B0Yyjm6ve2BjIKCgJCUhIEGgAgWA%3D%3D",
                     `x-origin` = "https://charts.youtube.com",
                     `x-youtube-ad-signals` = "dt=1725822310004&flash=0&frm&u_tz=-180&u_his=3&u_h=1080&u_w=1920&u_ah=1032&u_aw=1920&u_cd=24&bc=31&bih=911&biw=806&brdim=1537%2C-215%2C1537%2C-215%2C1920%2C-216%2C1918%2C1030%2C821%2C911&vis=1&wgl=true&ca_type=image",
                     `x-youtube-client-name` = "31",
                     `x-youtube-client-version` = "2.0",
                     `x-youtube-page-cl` = "663262755",
                     `x-youtube-time-zone` = "America/Fortaleza",
                     `x-youtube-utc-offset` = "-180",
                   ) |> 
                   httr2::req_body_raw(
                     str_glue(
                       '{{"context": {{"client": {{"clientName": "WEB_MUSIC_ANALYTICS","clientVersion": "2.0","hl": "pt","gl": "BR","experimentIds": [],"experimentsToken": "", "theme": "MUSIC"}}, "capabilities": {{}}, "request": {{"internalExperimentFlags": []}}}}, "browseId": "FEmusic_analytics_insights_location", "query": "perspective=LOCATION&entity_params_entity=LOCATION&location_params_id={.x}&date_params_start_time={str_extract(.y,str_extract(.y,"[:graph:]{10}"))}T03%3A00%3A00Z&date_params_end_time={str_extract(.y,str_extract(.y,"[:graph:]{10}$"))}T03%3A00%3A00Z&date_params_interval=DAY"}}'
                     ),
                     "application/json"
                   ) %>% 
                   httr2::req_perform() %>% 
                   httr2::resp_body_json()
                }
                        
                        
)
}
