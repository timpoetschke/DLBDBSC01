# validate_raw_data.R
# ---------------------------------------------
# Skript zur Validierung der importierten Rohdaten
# für GDP per Capita, Fertility Rate und Life Expectancy
# ---------------------------------------------

# Bibliotheken laden
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("readxl", quietly = TRUE)) install.packages("readxl")
if (!requireNamespace("zoo", quietly = TRUE)) install.packages("zoo")
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")

library(dplyr)
library(readxl)
library(zoo)
library(ggplot2)

# ---------------------------------------------
# 1. Daten einlesen
# ---------------------------------------------

# Achtung: Passe hier die Pfade an deine Ordnerstruktur an
gdp_per_capita <- read_excel("input/gdp_per_capita_raw.xls", sheet = "Data", skip = 3)
fertility_rate <- read_excel("input/fertility_rate_raw.xls", sheet = "Data", skip = 3)
life_expectancy <- read_excel("input/life_expectancy_raw.xls", sheet = "Data", skip = 3)

# ---------------------------------------------
# 2. Struktur der Daten überprüfen
# ---------------------------------------------

str(gdp_per_capita)
str(fertility_rate)
str(life_expectancy)

# ---------------------------------------------
# 3. Fehlende Werte analysieren
# ---------------------------------------------

# Summen der fehlenden Werte je Datensatz
cat("\nFehlende Werte pro Indikator:\n")
colSums(is.na(gdp_per_capita))
colSums(is.na(fertility_rate))
colSums(is.na(life_expectancy))

# Anzahl der Länder mit fehlenden Werten
cat("\nAnzahl der Länder mit fehlenden GDP-Werten:\n")
sum(rowSums(is.na(gdp_per_capita[, 5:ncol(gdp_per_capita)])) > 0)

cat("\nAnzahl der Länder mit fehlenden Fertility-Werten:\n")
sum(rowSums(is.na(fertility_rate[, 5:ncol(fertility_rate)])) > 0)

cat("\nAnzahl der Länder mit fehlenden Life Expectancy-Werten:\n")
sum(rowSums(is.na(life_expectancy[, 5:ncol(life_expectancy)])) > 0)

# ---------------------------------------------
# 4. Grundlegende Verteilungen analysieren
# ---------------------------------------------

# Histogramme der Werte ab Jahr 2000 (sofern vorhanden)

# Achtung: Spalten ab Jahr 2000 manuell auswählen, je nach World Bank Exportstruktur
years_cols <- which(names(gdp_per_capita) == "2000"):which(names(gdp_per_capita) == "2019")

# GDP per capita
gdp_long <- unlist(gdp_per_capita[, years_cols])
gdp_long <- na.omit(gdp_long)
hist(gdp_long, main = "GDP per capita 2000-2019", xlab = "GDP per capita (US$)", breaks = 30, col = "lightblue")

# Fertility Rate
fertility_long <- unlist(fertility_rate[, years_cols])
fertility_long <- na.omit(fertility_long)
hist(fertility_long, main = "Fertility Rate 2000-2019", xlab = "Fertility Rate (births per woman)", breaks = 30, col = "lightgreen")

# Life Expectancy
life_long <- unlist(life_expectancy[, years_cols])
life_long <- na.omit(life_long)
hist(life_long, main = "Life Expectancy 2000-2019", xlab = "Life Expectancy at Birth (years)", breaks = 30, col = "lightpink")

# ---------------------------------------------
# 5. Ausreißer visuell überprüfen
# ---------------------------------------------

# GDP per capita Boxplot
boxplot(gdp_long, main = "Boxplot GDP per capita", horizontal = TRUE, col = "lightblue")

# Fertility Rate Boxplot
boxplot(fertility_long, main = "Boxplot Fertility Rate", horizontal = TRUE, col = "lightgreen")

# Life Expectancy Boxplot
boxplot(life_long, main = "Boxplot Life Expectancy", horizontal = TRUE, col = "lightpink")

# ---------------------------------------------
# 6. Zusammenfassung der Verteilungen
# ---------------------------------------------

cat("\nZusammenfassung der GDP per capita Werte:\n")
summary(gdp_long)

cat("\nZusammenfassung der Fertility Rate Werte:\n")
summary(fertility_long)

cat("\nZusammenfassung der Life Expectancy Werte:\n")
summary(life_long)

# ---------------------------------------------
# 7. Hinweise
# ---------------------------------------------

cat("\nHinweis: Stark asymmetrische Verteilungen oder Extremwerte könnten bei weiteren Analysen (z.B. Regressionen) eine Transformation sinnvoll machen.\n")

# Ende des Skripts
