####################################################################################
### EXERCÍCIOS DA AULA 4                                                         ###
### DATA: 2018-01-27                                                             ###
### ARQUIVO: exercicios.R                                                        ###
### AUTOR: Caio Lente + Curso-R                                                  ###
####################################################################################

fds

### PREPARAÇÃO #####################################################################

# Carregar bibliotecas necessárias
library(tidyverse)
library(stringr)
library(lubridate)



### STRINGR ########################################################################

### O QUE SÃO STRINGS? -------------------------------------------------------------

# 06.1: Rode a função `class()` em uma string. O que ela realmente é?

minha_string <- "O céu é azul"
class(minha_string)

# 07.1: Verifique as diferenças entre o comportamento entre `print()` e `cat()`.


cat("Meu nome é \"Caio Lente\"")
print("Meu nome é \"Caio Lente\"")

# 10.1: Crie um vetor que carrega dois pequenos textos. Cada texto deve ter dois
# parágrafos cada e cada parágrafo deve ter pelo menos 3 linhas. Cada parágrafo deve
# começar com uma tabulação e nenhuma linha pode passar de 80 caracteres. Pelo menos
# um dos textos deve ter uma citação.

strings <- c("",
             "")



### MEXER COM STRINGS É FÁCIL ------------------------------------------------------

# 12.1: Carregue o `stringr` e procure por suas funções usando a tecla TAB.


# 12.2: Verifique como são contados caracteres escapados.


# 14.1: Tabulações são consideradas espaços?


# 14.2: Teste `str_sub()` dando valor só para `start` ou só para `end`. O que
# acontece se passarmos números negativos para ambos os parâmetros?

str_sub(c("__SP__", "__MG__", "__RJ__"), start = -4, end = -3)


# 15.1: E se passássemos uma variável numérica para essa função?

v <- 0.03
str_c("O valor p é: ", v)


# 15.2: Use o argumento `sep` para remover a repetição de espaços. Use o
# argumento `collapse` para juntar as duas frases em uma.

s1 <- c("O R", "O Java")
s2 <- c("bom", "ruim")
str_c(s1, "é muito", s2, sep = " ", collapse = " e ")


# 16.1: Partindo do vetor de strigs `vs`, obtenha o texto `s`:

vs <- c("***O número   " , "de caRACTeres", "   nEste TexTO", "é")
s <- "o número de caracteres neste texto é 36"

vs1 <- str_to_lower(vs)
vs2 <- str_trim(vs1)
vs3 <- str_c(vs2, collapse = " ")
vs4 <- str_sub(vs3, start = 4)
vs5 <- str_c(vs4, str_length(vs4), sep = " ")


### REGEX --------------------------------------------------------------------------

# 18.1: Mude o valor do argumento `pattern` no código abaixo para que a
# expressão dê match com qualquer string que tenha como segunda letra um
# `a` minúsculo.

str_detect(c("banana", "BANANA", "maca", "nona"), pattern = "^...a")


# 19.1: Como faríamos para dar match em um padrão já escapado (como "\\.")?
# Dê match em um caractere de nova linha e em um caractere de tabulação.

s <- "a\\t\\na"
str_detect(s, "\\\\t")

# 22.1: Dado o corpus presente em `stringr::words`, crie expressões regulares que
# casem com as palavras que:
#
# - Começam com 3 consoantes
# - Têm 3 ou mais vogais em sequência
# - Têm duas ou mais ocorrências onde uma vogal precede uma consoante

str_view(stringr::words, pattern = "^[^aeiouAEIOU]{3}", match = TRUE)
str_view(stringr::words, pattern = "[aeiouAEIOU]{3,}", match = TRUE)
str_view(stringr::words, pattern = "([aeiouAEIOU][^aeiouAEIOU]){2,}", match = TRUE)


### MEXER COM STRINGS É DIFÍCIL ----------------------------------------------------

# 26.1: Dado um número de 11 dígitos, transforme-o em um CPF da forma
# `544.916.518-84`.

num <- c(54491651884, 12345678901, 10932478919)
str_replace(num, pattern = "([0-9]{3})([0-9]{3})([0-9]{3})([0-9]{2})",
            replacement = "\\1.\\2.\\3-\\4")


# 28.1: O que acontece quando quebramos as strings do vetor `pessoas` em
# todas as letras (usando `str_match_all()`)?

pessoas <- c("Silva, João", "Lima, Joana", "Madonna")
str_match_all(pessoas, "[:alpha:]")


# 30.1: Partindo de `stringr::sentences`, crie o vetor `no_the`, onde todas as
# ocorrências da palavra "the" (ou "The") são removidas (mas tendo em mente que
# as frases devem continuar começando com letra maiúscula)

stringr::sentences %>%
  str_replace_all(pattern = "[Tt]he ?", replacement = "") %>%
  dplyr::tibble(sentence = .) %>% 
  dplyr::mutate(
    first = str_extract(sentence, "^[:alpha:]"),
    first = str_to_upper(first),
    sentence = str_replace(sentence, "^[:alpha:]", first)) %>%
  dplyr::pull(sentence)



### LUBRIDATE ######################################################################

### O QUE SÃO DATAS? ---------------------------------------------------------------

# 34.1: O que acontece quando convertemos uma data-hora anterior a 1970?


# 34.2: O que de interessante aconteceu quando adicionamos 1 mês (2592000 segundos)
# a `now()`?

now()
now() + 2592000


# 36.1: Analise 3 conjuntos de funções: `as_date()` e `as_datetime()`, `make_date()`
# e `make_datetime()`, `date()`. O que diferencia esses grupos de funções? Por que
# não existe uma função `datime()`?


### CRIANDO DATAS ------------------------------------------------------------------

# 38.1: Passe uma data para `as_datetime()` e uma data-hora para `as_date()`.


# 39.1: O que acontece se passarmos o número `20012018` para a função `dmy()`?


# 39.2: E se não quisermos especificar os minutos ou segundos de um datetime?


# 40.1: Crie um vetor `c(t1, t2)`. O que acontece quando você o imprime?

t1 <- dmy_hms("01/06/2015 12:00:00", tz = "America/New_York")
t2 <- dmy_hms("01/06/2015 13:00:00", tz = "America/Sao_Paulo")
c(t1, t2)


# 40.2: Dê uma olhada na lista de fusos presentes em `OlsonNames()`.


# 41.1: Partindo do vetor de strigs `vt`, obtenha a data-hora `t`. Você deve fazer
# isso de duas formas diferentes: uma deve usar somente o pacote `lubridate` e a
# outra deve usar o pacote `stringr` também.

vt <- c("2015", "31", "03", "02", "59")
t <- ymd_hm("2015-03-31 02:59")

make_datetime(vt[1], vt[3], vt[2], vt[4], vt[5])
ydm_hm(str_c(vt, collapse = "-"))


### MEXER COM DATAS É FÁCIL --------------------------------------------------------

# 43.1: Para que servem os argumentos de `wday()`?


# 44.1: Tente atribuir um valor inválido (maior que `31`) para `day(dt)`

dt <- ymd_hms("2016-07-08 12:34:56")


### MEXER COM DATAS É DIFÍCIL ------------------------------------------------------

# 48.1: Encontre a data de amanhã usando `today()` e um construtor de duração.


# 49.1: Onde mais esse tipo de diferença poderia aparecer?


# 50.1: `(today() %--% (today() + years(1))) / months(1)` funciona?


# 51.1: Partindo de `lubridate::lakers`, determine, em média, quanto tempo o
# Lakers (`team == "LAL"`) demora para arremessar a primeira bola (`etype == "shot"`)
# no primeiro período (`period == 1`).

lakers %>% 
  dplyr::filter(etype == "shot", period == 1, team == "LAL") %>% 
  dplyr::mutate(time = as.duration(ms(time))) %>%
  dplyr::group_by(date) %>%
  dplyr::summarise(first = min(time)) %>%
  dplyr::pull(first) %>%
  mean()
