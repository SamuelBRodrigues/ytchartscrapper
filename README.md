# Pacote de Extração de Dados do YouTube Charts

## Descrição

Este pacote fornece funções para extrair os 20 artistas e as 20 músicas mais populares em diferentes cidades e estados do Brasil, utilizando a API do YouTube Charts. Ele permite a coleta e organização desses dados para análises musicais e estatísticas.

## Funcionalidades

- **`dados_yt_charts(id, time_period)`**: Extrai os dados do YouTube Charts para um determinado local e período de tempo.
- **`estados_alvo()`**: Retorna uma lista de estados brasileiros que podem ser consultados.
- **`municipios_alvo(pop = 70000)`**: Retorna uma lista de municípios brasileiros com população acima de um determinado valor (padrão de 70.000 habitantes).
- **`url_estados_cidade_br(alvo_query)`**: Gera a URL necessária para consulta na API do YouTube Charts com base no estado ou cidade.
- **`extrai_id(url_estados_cidades_br, time_period)`**: Extrai os identificadores únicos de cidades e estados para a consulta na API.
- **`extrai_artistas(dados_yt_charts, alvo)`**: Processa os dados extraídos e retorna um data frame com os 20 artistas mais populares de cada localidade.
- **`extrai_musicas(dados_yt_charts, alvo)`**: Processa os dados extraídos e retorna um data frame com as 20 músicas mais populares de cada localidade.

## Instalação

Para utilizar este pacote, você deve ter o R instalado e carregar as bibliotecas necessárias. Caso ainda não tenha, instale os pacotes necessários:

```r
install.packages(c("httr2", "purrr", "dplyr", "tidyr", "stringr", "readxl", "janitor", "geobr", "readr"))
```

Em seguida, carregue o pacote e suas dependências:

```r
library(httr2)
library(purrr)
library(dplyr)
library(tidyr)
library(stringr)
library(readxl)
library(janitor)
library(geobr)
library(readr)
```

## Exemplo de Uso

```r
# Extraindo os IDs de estados e cidades
ids <- extrai_id(url_estados_cidade_br(estados_alvo()))

# Obtendo dados do YouTube Charts
dados <- dados_yt_charts(id = ids$id, time_period = c("2023-09", "2023-10"))

# Extraindo artistas populares
top_artistas <- extrai_artistas(dados, estados_alvo())

# Extraindo músicas populares
top_musicas <- extrai_musicas(dados, estados_alvo())

# Visualizando os resultados
head(top_artistas)
head(top_musicas)
```

## Autor

Este pacote foi desenvolvido para facilitar a extração de dados do YouTube Charts e auxiliar em análises musicais regionais no Brasil.

- [SamuelBRodrigues](https://github.com/SamuelBRodrigues)
- [BaruqueRodrigues](https://github.com/BaruqueRodrigues)
