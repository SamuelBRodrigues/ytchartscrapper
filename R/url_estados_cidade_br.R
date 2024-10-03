url_estados_cidade_br <- function(alvo_query){
  
  map(alvo_query,
      ~ httr2::request("https://clients1.google.com/complete/search") |>
        httr2::req_url_query(
          client = "yt-music-charts",
          hl = "en",
          gs_rn = "64",
          gs_ri = "yt-music-charts",
          cp = "9",
          gs_id = "5k",
          q = .x,
          callback = "google.sbox.p50",
          gs_gbg = "1kMrVtu3kHy5optTH0",
        ) |>
        httr2::req_headers(
          accept = "*/*",
          `accept-language` = "pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7",
          cookie = "__Secure-3PAPISID=HoiZPBeuvlZg6uu7/A1F5A4odrZ6YaPpO7; __Secure-3PSID=g.a000nQiMlOnSaYR3dnMOQY1u4Eoz4FFFIPWkVAjUCpWugqIQc8KbG_rGNk956ppAuO6nfuDKYwACgYKAQkSARUSFQHGX2MiM50ecWrjCeH0_aS1oMrpVBoVAUF8yKq2RPzTdG1ZKlUKDwlwWg150076; NID=517=beSpnn2o2gXPp0Hy5IdFdgyzvDU5rJQmqz1t2NYTGq3pHy9PdFFZSnF4YBbSr8ves4mn7-Zvr3gpW6Gl4Ac1u1VEwu3W5UqSrGZ_fhSptrhl8Wxnv-QYY8kRm2hwtywHGSz8nUdYjwaYg2TA7XQZBsPcMEDQkSy_zfJ4SkDOW6Z2cwKu466tEQSf-gGOfFuzLwb9C1zoJVP4HT_-u0KxwV2L_-hDErgDYpxn1ErjEGdmPTn3RCEVW5qb6OaKa-GZbaJturZEQD-5gf6NhB_RXuiemHkzpcadVOxUWHqE5N3ybSdThkVqi4Dc-Y-_9AFc5INqK5VF1D7ocrzAG-w-ExB6ggeJZBIGfcVw1ZXDzHCtRYfDUrCgfVgAq-lnxRcatOD1mMayGW-SiLeQaE2ciD3bjuG1df1sQL71YZXpSHcvWJDZKtXif800egXQUsVRTgMngKJAqjP8vjWKs4cCza-kqudj-lNSPSWcdNnbVGpkU8_KjLHlezu4vzqccSLC_keVGVb03yG3JQ_9M3piIgFzTpY4K-lx40vpsiAUxuhwkwXuCTGls_nhzFWkDBHTk9ZgHIDAsevX4caD9WNqsniSu2lWG1HacH6xRM6qNAeY5vHJUIi-iWcd4X462RH0gfICa4DZ1aK0cVEBQaQpH3uQ7Xa5y0PuDB2LQf2sZoWShOPiiWXElf0RCm2X0CglkJMwv7FGpmX7utw6VS1Mndgb7FcvKBBn6SgYiUzhmEKQkiSxwR9kF_TjuCFlDZ7_mVRNjoaVkzxc_dTiJboIbN__CW7VASeH5LsO5ZAMbPJ9ZdUq3rPDw2dv0PDhypZJ07RQMWPABaIWbT7-tf2MVEhTWqa0zgP3cGUotReAkx1djtnY0NfjwTr7BFg1LavoePsdza0INxiXhco0QA7D3qSYBu9Zq_VXWN5LZ1C3Kc6Bhs1EmcD3OpiQeMZSyKkybSzsBh5BoNs8JIbl4e7NT5iKz6CKhaojsKAPZcm6Vxe-QlQsTLHieiBdDDNbi4ObUnkEdJKJlA2jWvTRzcCM7hcWDjX9p7t2eIQ4Ydpre3HGCFGTPTQS-NJRm98raGgbuY6E4jLAdQ2wvpEpgmO5jwtfhaKJEHuBu5ueaAWyf_U-Xdpn_mGd8tDyLSI0s_4OJJcJLPx_24OrUKIWzrBmAX04RgNipk-HH2E0VOHOCKX5jztS4Qaz3tB-b61m6yABswLQpR60TreRtSsMIM8tEDxiEv_cTuItmRdv1L1CVN_Zbukgjx5ZrZWGqEhprNm8Tpmik45mZBAU2H0twmNJFaOh0ucluYKOKV-ZQooYIVkFf74_HnBNDPmvMK-p_b6F1GuMV2-NTutHlK8Bml9VWV5lwoYNW1mN8L1EdhMoISlU0rqqWlrCQEuPUs_5yN5g; __Secure-3PSIDTS=sidts-CjIBUFGoh3eeHkvO82YA5fRbgSnyYR8BCiHptuDTXaVFEhsdZUdWZ86mWUwIuKpigLBauxAA; __Secure-3PSIDCC=AKEyXzUGisLqxmsXGE7SfOQ1uHA90H36Y1dCuGvlWYjzcGedIbcnMnZOb7cPVWOSQSgR9eULa3Y",
          `user-agent` = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 OPR/112.0.0.0",
          `x-client-data` = "CMqGywE=",
        ) |>
        httr2::req_perform() |>
        httr2::resp_body_string()
  )
  
}

