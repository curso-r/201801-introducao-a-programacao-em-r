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

gather(cases, year, n, 2:4)


# spread ------------------------------------------------------------------

spread(pollution, size, amount)


# separate ----------------------------------------------------------------

storms2 <- separate(storms, date, c("year", "month", "day"), sep = "-")


# unite -------------------------------------------------------------------

unite(storms2, "date", year, month, day, sep = "-")



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

nas
filter(nas, is.na(a))
filter(nas, !is.na(a))


# mutate ------------------------------------------------------------------

mutate(storms, ratio = pressure/wind, inverse = 1/ratio)
mutate(storms, last_storm = lag(storm, order_by = date))


# summarise ---------------------------------------------------------------

summarise(pollution, median = median(amount), mean = mean(amount))
summarise(pollution, mean = mean(amount), sum = sum(amount), n = n())


# arrange -----------------------------------------------------------------

arrange(storms, wind)
arrange(storms, desc(wind))

# pipe --------------------------------------------------------------------

esfrie(asse(coloque(bata(acrescente(recipiente(
  rep("farinha", 2), "água", "fermento", "leite", "óleo"), 
  "farinha", até = "macio"), 
  duração = "3min"), 
  lugar = "forma", tipo = "grande", untada = TRUE), duração = "50min"), 
  "geladeira", "20min")

recipiente(rep("farinha", 2), "água", "fermento", "leite", "óleo") %>%
  acrescente("farinha", até = "macio") %>%
  bata(duraço = "3min") %>%
  coloque(lugar = "forma", tipo = "grande", untada = TRUE) %>%
  asse(duração = "50min") %>%
  esfrie("geladeira", "20min")



select(storms, storm, pressure)
storms %>% select(storm, pressure)

filter(storms, wind >= 50)
storms %>% filter(wind >= 50)

storms %>%
  filter(wind >= 50) %>%
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
