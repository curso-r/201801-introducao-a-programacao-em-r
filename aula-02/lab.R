# install.packages("devtools")
# install.packages("tidyr")
# install.packages("dplyr")
# devtools::install_github("rstudio/EDAWR")

library(EDAWR)

# Help das bases de dados -------------------------------------------------

?storms
?cases
?pollution
?tb

# Acessando as variáveis --------------------------------------------------

storms

storms$storm
storms$wind
storms$pressure
storms$date

storms[["storm"]]
storms["storm"]
storms[1,1]


cases

cases$country
names(cases)[-1]
unlist(cases[1:3, 2:4])

pollution

pollution$city[c(1,3,5)]
pollution$amount[c(1,3,5)]
pollution$amount[c(2,4,6)]


# gather ------------------------------------------------------------------
library(tidyr)

cases
library(dplyr)
gather(cases, year, n, `2011`, `2012`, `2013`)


# spread ------------------------------------------------------------------

pollution <- EDAWR::pollution
pollution

pollution2 <- rbind(pollution, pollution[1:2,])
spread(pollution2, size, amount)

pollution2 <- pollution
pollution2$pop <- 1:6
spread(pollution2, size, amount, fill = 0)

pollution_s <- spread(pollution, size, amount)
pollution_g <- gather(pollution_s, size, amount, 2:3)

# separate ----------------------------------------------------------------
storms <- EDAWR::storms
storms2 <- separate(storms, date, c("year", "month", "day"), sep = "-", remove = TRUE)

df <- data.frame(x = c("a+b+c", "a+b", "a+b+c+d"))
df

separate(df, x, c("a", "b", "c"), extra = "merge", fill = "left")

# unite -------------------------------------------------------------------

storms2
unite(storms2, "date", year, month, day, sep = "-")
unite(storms2, "date", starts_with(), starts_with("d") , sep = "-")

?starts_with
help("starts_with")
starts_with

# dplyr -------------------------------------------------------------------

library(dplyr)

?select
?arrange
?mutate
?filter
?summarise
?group_by

# select ------------------------------------------------------------------

storms <- EDAWR::storms
select(storms, storm, pressure)
select(storms, -storm)
select(storms, wind:date)


# filter ------------------------------------------------------------------

filter(storms, wind >= 50, storm %in% c("Alberto", "Alex", "Allison"))

x <- c("a", "b", "c", "d")
x
x == "a"
x == "a" | x == "b" | x == "c"
x %in% c("a", "b", "c")
x == c("a", "b", "c")

nas

x <- c(NA, 1, 2, 3)
x == NA
is.na(x)

nas

filter(nas, is.na(a))
filter(nas, !is.na(a))

c(NA, 1, 2, 3)
# mutate ------------------------------------------------------------------

mutate(storms, ratio = pressure/wind, inverse = 1/ratio)
storms
View(mutate(storms, last_storm = lag(storm, order_by = date)))
storms
storms <- mutate(
  storms, 
  ratio2 = ifelse(storm %in% c("Alberto", "Alex"), pressure/wind, NA)
  )

# summarise ---------------------------------------------------------------
pollution
summarise(pollution, median = median(amount), mean = mean(amount))
summarise(pollution, mean = mean(amount), sum = sum(amount), n = n_distinct(city))

# arrange -----------------------------------------------------------------

arrange(storms, wind, pressure, date)
arrange(storms, desc(wind))

# pipe --------------------------------------------------------------------

esfrie(asse(coloque(bata(acrescente(
  recipiente(
  rep("farinha", 2), "água", "fermento", "leite", "óleo"), "farinha", até = "macio"), duração = "3min"), 
  lugar = "forma", tipo = "grande", untada = TRUE), duração = "50min"), 
  "geladeira", "20min")

recipiente(rep("farinha", 2), "água", "fermento", "leite", "óleo") %>%
  acrescente("farinha", até = "macio") %>%
  bata(duraçao = "3min") %>%
  coloque(lugar = "forma", tipo = "grande", untada = TRUE) %>%
  asse(duração = "50min") %>%
  esfrie("geladeira", "20min")



select(storms, storm, pressure)
storms %>% select(storm, pressure)

filter(storms, wind >= 50)
storms %>% filter(wind >= 50)

t <- 50
storms %>%
  filter(wind >= t) %>% 
  select(storm, pressure)

storms %>%
  mutate(ratio = pressure/wind) %>%
  select(storm, ratio)


# group_by + summarise ----------------------------------------------------

pollution %>% 
  summarise( mean = mean(amount), sd = sd(amount), n = n())

pollution %>% 
  group_by(city) %>%
  summarise( mean = mean(amount), sd = sd(amount), n = n())

pollution %>% 
  group_by(city) %>%
  mutate( ratio = amount/mean(amount)) %>%
  ungroup()

# joins -------------------------------------------------------------------

y
z

bind_cols(y, z)
bind_rows(y, z)

union(y, z)
intersect(y, z)
setdiff(y, z)

songs %>% left_join(artists)
songs %>% left_join(artists, by = "name")

songs2 %>% left_join(artists2)
songs2 %>% left_join(artists2, by = c("first", "last"))

songs %>% inner_join(artists, by = "name")

songs %>% semi_join(artists, by = "name")

songs %>% anti_join(artists, by = "name")

# ler dados ---------------------------------------------------------------

library(readr)

library(readr)
tb <- read_csv("_dados/tb.csv", locale = locale(decimal_mark = ","))
View(tb)

df <- data.frame(x = c())
df <- read_delim("_dados/dados.txt", delim = "|", 
                 col_types = list(coluna2 = col_number()), locale = locale(decimal_mark = ","))


DBI::dbGetQuery(con, "select top 10 * from jhajs")
DBI::dbWriteTable()
