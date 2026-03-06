# Načtení potřebných balíčků
library(MASS)       # obsahuje dataset Boston
library(ggplot2)    # pro vizualizaci dat
library(pls)        # pro PCR
library(caret)      # pro rozdělení na trénovací a testovací sadu
library(corrplot)   # pro korelační matice

# Načtení datasetu Boston
data("Boston", package = "MASS")
head(Boston)

# Základní popis dat
summary(Boston)
str(Boston)

# Korelační matice + uložení do souboru
cor_matrix <- cor(Boston)
png("correlation_matrix.png", width = 800, height = 800)
corrplot::corrplot(cor_matrix, method = "color", tl.cex = 0.8)
dev.off()

# Vizualizace - distribuce cílové proměnné
# Histogram mediánové ceny
hist_medv <- ggplot(Boston, aes(x = medv)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "black") +
  theme_minimal() +
  ggtitle("Distribuce mediánové ceny domů (medv)")

# Zobrazení a uložení histogramu
print(hist_medv)
ggsave("histogram_medv.png", plot = hist_medv, width = 6, height = 4)

# Rozdělení dat na trénovací a testovací sadu
set.seed(42)  # pro reprodukovatelnost
train_index <- caret::createDataPartition(Boston$medv, p = 0.5, list = FALSE)
train_data <- Boston[train_index, ]
test_data <- Boston[-train_index, ]

# Lineární regrese
lm_model <- lm(medv ~ ., data = train_data)
summary(lm_model)

# Predikce a RMSE na testovací množině
lm_pred <- predict(lm_model, newdata = test_data)
lm_rmse <- sqrt(mean((test_data$medv - lm_pred)^2))
cat("RMSE pro lineární regresi:", lm_rmse, "\n")

# PCR - standardizace dat (scale = TRUE)
pcr_model <- pls::pcr(medv ~ ., data = train_data, scale = TRUE,
                      validation = "CV")
summary(pcr_model)

# Vyhodnocení RMSE pro různé komponenty
# Validation plot + uložení do souboru
png("pcr_validationplot.png", width = 800, height = 600)
validationplot(pcr_model, val.type = "MSEP",
               main = "RMSE v závislosti na počtu komponent")
dev.off()

# Predikce z PCR - s 6 komponentami
pcr_pred <- predict(pcr_model, newdata = test_data, ncomp = 6)
pcr_rmse <- sqrt(mean((test_data$medv - pcr_pred)^2))
cat("RMSE pro PCR (6 komponent):", pcr_rmse, "\n")

# Závěr - porovnýní modelů
if (lm_rmse < pcr_rmse) {
  cat("Lepší model: klasická lineární regrese\n")
} else {
  cat("Lepší model: PCR\n")
}