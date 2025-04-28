# cleanup.R

if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("tidyr", quietly = TRUE)) install.packages("tidyr")
if (!requireNamespace("zoo", quietly = TRUE)) install.packages("zoo")

library(dplyr)
library(tidyr)
library(zoo)

threshold <- 0.3

cleanup_dataset <- function(data) {
  data_with_ratio <- data %>% 
    rowwise() %>% 
    mutate(available_ratio = mean(!is.na(c_across(where(is.numeric)))))
  
  removed_countries <- data_with_ratio %>%
    filter(available_ratio < threshold) %>%
    pull(1) 
  
  valid_countries <- data_with_ratio %>% 
    filter(available_ratio >= threshold) %>% 
    select(-available_ratio)
  
  interpolated_data <- valid_countries %>%
    mutate(across(where(is.numeric), ~ na.approx(., na.rm = FALSE)))
  
  interpolated_countries <- valid_countries %>%
    rowwise() %>%
    mutate(has_na = any(is.na(c_across(where(is.numeric))))) %>%
    filter(has_na) %>%
    pull(1)
  
  cat("Länder, die im ersten Normalisierungsschritt entfernt wurden:\n")
  print(removed_countries)
  cat("\nLänder, bei denen eine Interpolation durchgeführt wurde:\n")
  print(interpolated_countries)
  
  return(interpolated_data)
}

data_path <- "output/"

# Lade alle Datensätze
load(paste0(data_path, "gdp_per_capita.RData"))
load(paste0(data_path, "fertility_rate.RData"))
load(paste0(data_path, "life_expectancy.RData"))
load(paste0(data_path, "basic_sanitation_services.RData"))
load(paste0(data_path, "basic_drinking_water_services.RData"))
load(paste0(data_path, "undernourishment.RData"))
load(paste0(data_path, "homicides.RData"))
load(paste0(data_path, "literacy.RData"))
load(paste0(data_path, "education_expenditure.RData"))

# Cleanup aller Datensätze
gdp_per_capita_clean <- cleanup_dataset(gdp_per_capita)
fertility_rate_clean <- cleanup_dataset(fertility_rate)
life_expectancy_clean <- cleanup_dataset(life_expectancy)
basic_sanitation_services_clean <- cleanup_dataset(basic_sanitation_services)
basic_drinking_water_services_clean <- cleanup_dataset(basic_drinking_water_services)
undernourishment_clean <- cleanup_dataset(undernourishment)
homicides_clean <- cleanup_dataset(homicides)
literacy_clean <- cleanup_dataset(literacy)
education_expenditure_clean <- cleanup_dataset(education_expenditure)

# Speichern der bereinigten Datensätze
save(gdp_per_capita_clean, file = paste0(data_path, "gdp_per_capita_clean.RData"))
save(fertility_rate_clean, file = paste0(data_path, "fertility_rate_clean.RData"))
save(life_expectancy_clean, file = paste0(data_path, "life_expectancy_clean.RData"))
save(basic_sanitation_services_clean, file = paste0(data_path, "basic_sanitation_services_clean.RData"))
save(basic_drinking_water_services_clean, file = paste0(data_path, "basic_drinking_water_services_clean.RData"))
save(undernourishment_clean, file = paste0(data_path, "undernourishment_clean.RData"))
save(homicides_clean, file = paste0(data_path, "homicides_clean.RData"))
save(literacy_clean, file = paste0(data_path, "literacy_clean.RData"))
save(education_expenditure_clean, file = paste0(data_path, "education_expenditure_clean.RData"))
