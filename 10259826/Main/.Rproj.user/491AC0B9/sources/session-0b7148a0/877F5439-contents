rm(list = ls())

if (!requireNamespace("readxl", quietly = TRUE)) {
  install.packages("readxl")
}
library(readxl)

getwd()

# GDP per capita
gdp_per_capita <- read_excel(
  path = "input/gdp_per_capita_raw.xls",
  sheet = "Data",
  skip = 3
)
str(gdp_per_capita)
head(gdp_per_capita)
save(gdp_per_capita, file = "output/gdp_per_capita.RData")

# Fertility rate
fertility_rate <- read_excel(
  path = "input/fertility_rate_raw.xls",
  sheet = "Data",
  skip = 3
)
str(fertility_rate)
head(fertility_rate)
save(fertility_rate, file = "output/fertility_rate.RData")

# Life expectancy
life_expectancy <- read_excel(
  path = "input/life_expectancy_raw.xls",
  sheet = "Data",
  skip = 3
)
str(life_expectancy)
head(life_expectancy)
save(life_expectancy, file = "output/life_expectancy.RData")

# Basic sanitation service
basic_sanitation_services <- read_excel(
  path = "input/basic_sanitation_services.xls",
  sheet = "Data",
  skip = 3
)
str(basic_sanitation_services)
head(basic_sanitation_services)
save(basic_sanitation_services, file = "output/basic_sanitation_services.RData")

# Basic drinking water service
basic_drinking_water_services <- read_excel(
  path = "input/basic_drinking_water_services.xls",
  sheet = "Data",
  skip = 3
)
str(basic_drinking_water_services)
head(basic_drinking_water_services)
save(basic_drinking_water_services, file = "output/basic_drinking_water_services.RData")


# Undernourishment
undernourishment <- read_excel(
  path = "input/undernourishment.xls",
  sheet = "Data",
  skip = 3
)
str(undernourishment)
head(undernourishment)
save(undernourishment, file = "output/undernourishment.RData")

# Homicides
homicides <- read_excel(
  path = "input/homicides.xls",
  sheet = "Data",
  skip = 3
)
str(homicides)
head(homicides)
save(homicides, file = "output/homicides.RData")

# Literacy
literacy <- read_excel(
  path = "input/literacy.xls",
  sheet = "Data",
  skip = 3
)
str(literacy)
head(literacy)
save(literacy, file = "output/literacy.RData")

# Education expenditure
education_expenditure <- read_excel(
  path = "input/education_expenditure.xls",
  sheet = "Data",
  skip = 3
)
str(education_expenditure)
head(education_expenditure)
save(education_expenditure, file = "output/education_expenditure.RData")
