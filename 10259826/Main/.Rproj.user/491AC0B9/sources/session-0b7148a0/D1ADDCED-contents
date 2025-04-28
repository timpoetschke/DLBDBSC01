# correlation_analysis.R

# Bibliotheken laden
if (!requireNamespace("tidyverse", quietly = TRUE)) install.packages("tidyverse")
if (!requireNamespace("GGally", quietly = TRUE)) install.packages("GGally")
if (!requireNamespace("patchwork", quietly = TRUE)) install.packages("patchwork")
if (!requireNamespace("janitor", quietly = TRUE)) install.packages("janitor")

library(tidyverse)
library(GGally)
library(patchwork)
library(janitor)

# Clean-Datensätze laden
load("output/gdp_per_capita_clean.RData")
load("output/fertility_rate_clean.RData")
load("output/life_expectancy_clean.RData")
load("output/literacy_clean.RData")

# Umbenennung
literacy_rate <- literacy_clean
rm(literacy_clean)

# Ins Long-Format bringen
gdp_per_capita_long <- gdp_per_capita %>%
  pivot_longer(cols = `1960`:`2023`, names_to = "Year", values_to = "gdp_per_capita") %>%
  mutate(Year = as.integer(Year))

fertility_rate_long <- fertility_rate %>%
  pivot_longer(cols = `1960`:`2023`, names_to = "Year", values_to = "fertility_rate") %>%
  mutate(Year = as.integer(Year))

life_expectancy_long <- life_expectancy %>%
  pivot_longer(cols = `1960`:`2023`, names_to = "Year", values_to = "life_expectancy") %>%
  mutate(Year = as.integer(Year))

literacy_rate_long <- literacy_rate %>%
  pivot_longer(cols = `1960`:`2023`, names_to = "Year", values_to = "literacy_rate") %>%
  mutate(Year = as.integer(Year))

# Zusammenführen der Daten
analysis_data <- gdp_per_capita_long %>%
  inner_join(fertility_rate_long, by = c("Country Name", "Country Code", "Year")) %>%
  inner_join(life_expectancy_long, by = c("Country Name", "Country Code", "Year")) %>%
  inner_join(literacy_rate_long, by = c("Country Name", "Country Code", "Year"))

# Auf Zeitraum 2000–2019 filtern
analysis_data <- analysis_data %>%
  filter(Year >= 2000, Year <= 2019)

# 1. Einzelplots erstellen

plot_gdp_literacy <- ggplot(analysis_data, aes(x = literacy_rate, y = gdp_per_capita)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "blue") +
  labs(
    title = "Hypothese a: Bildung vs GDP per capita",
    x = "Alphabetisierungsrate (%)",
    y = "GDP per capita (US$)"
  ) +
  theme_minimal()

plot_gdp_fertility <- ggplot(analysis_data, aes(x = fertility_rate, y = gdp_per_capita)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(
    title = "Hypothese b: Fertilitätsrate vs GDP per capita",
    x = "Fertilitätsrate (Kinder pro Frau)",
    y = "GDP per capita (US$)"
  ) +
  theme_minimal()

plot_gdp_lifeexp <- ggplot(analysis_data, aes(x = life_expectancy, y = gdp_per_capita)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "green") +
  labs(
    title = "Hypothese c: Lebenserwartung vs GDP per capita",
    x = "Lebenserwartung bei Geburt (Jahre)",
    y = "GDP per capita (US$)"
  ) +
  theme_minimal()

# 2. Pearson-Korrelationstests
cor_literacy_gdp <- cor.test(analysis_data$literacy_rate, analysis_data$gdp_per_capita, method = "pearson")
cor_fertility_gdp <- cor.test(analysis_data$fertility_rate, analysis_data$gdp_per_capita, method = "pearson")
cor_lifeexp_gdp <- cor.test(analysis_data$life_expectancy, analysis_data$gdp_per_capita, method = "pearson")

# 3. Zusammenfassung der Ergebnisse
cor_summary <- tibble(
  Hypothese = c("Bildung vs GDP", "Fertilität vs GDP", "Lebenserwartung vs GDP"),
  Korrelationskoeffizient = c(
    round(cor_literacy_gdp$estimate, 3),
    round(cor_fertility_gdp$estimate, 3),
    round(cor_lifeexp_gdp$estimate, 3)
  ),
  p_Wert = c(
    signif(cor_literacy_gdp$p.value, 3),
    signif(cor_fertility_gdp$p.value, 3),
    signif(cor_lifeexp_gdp$p.value, 3)
  )
)

# 4. Ergebnisse ausgeben
print("Korrelationsergebnisse:")
print(cor_summary)

# 5. Plots speichern in png/
ggsave("png/plot_gdp_literacy.png", plot = plot_gdp_literacy, width = 8, height = 6)
ggsave("png/plot_gdp_fertility.png", plot = plot_gdp_fertility, width = 8, height = 6)
ggsave("png/plot_gdp_lifeexp.png", plot = plot_gdp_lifeexp, width = 8, height = 6)

# Einzelne Plots + Kombiplot anzeigen
print(plot_gdp_literacy)
print(plot_gdp_fertility)
print(plot_gdp_lifeexp)

# 7. Ausgabe der Korrelationskoeffizienten und p-Werte in der Konsole

cat("\n--- Korrelationsanalyse Ergebnisse ---\n")

cat("\nHypothese a: Alphabetisierungsrate vs GDP per capita\n")
cat("Korrelationskoeffizient r =", round(cor_literacy_gdp$estimate, 3), "\n")
cat("p-Wert =", signif(cor_literacy_gdp$p.value, 3), "\n")

cat("\nHypothese b: Fertilitätsrate vs GDP per capita\n")
cat("Korrelationskoeffizient r =", round(cor_fertility_gdp$estimate, 3), "\n")
cat("p-Wert =", signif(cor_fertility_gdp$p.value, 3), "\n")

cat("\nHypothese c: Lebenserwartung vs GDP per capita\n")
cat("Korrelationskoeffizient r =", round(cor_lifeexp_gdp$estimate, 3), "\n")
cat("p-Wert =", signif(cor_lifeexp_gdp$p.value, 3), "\n")

cat("\n---------------------------------------\n")


# --- Ende des Skripts ---
