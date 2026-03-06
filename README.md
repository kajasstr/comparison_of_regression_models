# Multivariate Data Analysis: Comparison of Regression Models
This project evaluates and compares the predictive performance of two regression techniques: **Classical Linear Regression** and **Principal Component Regression (PCR)** using the Boston housing dataset.

### 📋 Project Overview
The goal was to predict the median housing price (`medv`) based on socioeconomic and environmental factors. A key focus was exploring how dimensionality reduction via PCA impacts model accuracy.

### 🛠️ Methodology & Tools
* **Exploratory Data Analysis (EDA)**: Correlation analysis and visualization of feature distributions using `ggplot2` and `corrplot`.
* **Dimensionality Reduction**: Implemented **Principal Component Analysis (PCA)** to transform predictors into orthogonal components, addressing potential collinearity.
* **Model Training**: 
  * Linear regression using all predictors.
  * PCR with **10-fold cross-validation** to determine the optimal number of components.
* **Evaluation**: Comparison of models based on **RMSE** (Root Mean Squared Error) on a 50/50 split of training and test data.

### 📈 Key Results
* PCR with **6 components** explained **85.55%** of the variance in the input data.
* **Final Comparison**:
    | Model | Test RMSE |
    | :--- | :--- |
    | Linear Regression | 4.63 |
    | PCR (6 components) | 4.88 |
* **Conclusion**: For this specific dataset, classical linear regression proved more accurate, although PCR remains a valuable tool for datasets with higher collinearity.

### 📂 Files
* `zapoctovy_ukol_1.R`: Full R source code for analysis and visualization.
* `zapoctova_uloha_Sustrova.pdf`: Detailed final report (in Czech).