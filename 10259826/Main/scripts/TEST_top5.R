rm(list = ls())

library(ggplot2)

load("output/gdp_per_capita.RData") 

gdp_2015 <- gdp_per_capita[, c("Country Name", "2015")]

colnames(gdp_2015) <- c("Country", "GDP_2015")

gdp_2015 <- na.omit(gdp_2015)

gdp_top5_2015 <- gdp_2015[order(-gdp_2015$GDP_2015), ][1:5, ]

ggplot(gdp_top5_2015, aes(x = reorder(Country, GDP_2015), y = GDP_2015)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "Top 5 Länder mit höchstem GDP 2015",
       x = "Land",
       y = "GDP pro Kopf (current US$)") +
  theme_minimal()
