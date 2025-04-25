Gender Classification
================
Trevor Okinda
2024

- [Student Details](#student-details)
- [Setup Chunk](#setup-chunk)
  - [Source:](#source)
  - [Reference:](#reference)
- [Understanding the Dataset (Exploratory Data Analysis
  (EDA))](#understanding-the-dataset-exploratory-data-analysis-eda)
  - [Loading the Dataset](#loading-the-dataset)
  - [Measures of Frequency](#measures-of-frequency)
  - [Measures of Central Tendency](#measures-of-central-tendency)
  - [Measures of Distribution](#measures-of-distribution)
  - [Measures of Relationship](#measures-of-relationship)
  - [ANOVA](#anova)
  - [Plots](#plots)
- [Preprocessing & Data
  Transformation](#preprocessing--data-transformation)
  - [Missing Values](#missing-values)
- [Training Models](#training-models)
  - [Data Splitting](#data-splitting)
  - [Bootstrapping](#bootstrapping)
  - [Training Different Models](#training-different-models)
  - [Performance Comparison Using
    Resamples](#performance-comparison-using-resamples)
  - [Saving Model](#saving-model)

# Student Details

|                       |                       |
|-----------------------|-----------------------|
| **Student ID Number** | 134780                |
| **Student Name**      | Trevor Okinda         |
| **BBIT 4.2 Group**    | C                     |
| **Project Name**      | Gender Classification |

# Setup Chunk

**Note:** the following KnitR options have been set as the global
defaults: <BR>
`knitr::opts_chunk$set(echo = TRUE, warning = FALSE, eval = TRUE, collapse = FALSE, tidy = TRUE)`.

More KnitR options are documented here
<https://bookdown.org/yihui/rmarkdown-cookbook/chunk-options.html> and
here <https://yihui.org/knitr/options/>.

### Source:

The dataset that was used can be downloaded here: *\<<a
href="https://www.kaggle.com/datasets/elakiricoder/gender-classification-dataset/data\"
class="uri">https://www.kaggle.com/datasets/elakiricoder/gender-classification-dataset/data\</a>\>*

### Reference:

*\<ElakiriCoder. (2023). Gender Classification Dataset \[Data set\].
Kaggle. <a
href="https://www.kaggle.com/datasets/elakiricoder/gender-classification-dataset\"
class="uri">https://www.kaggle.com/datasets/elakiricoder/gender-classification-dataset\</a>\>  
Refer to the APA 7th edition manual for rules on how to cite datasets:
<https://apastyle.apa.org/style-grammar-guidelines/references/examples/data-set-references>*

# Understanding the Dataset (Exploratory Data Analysis (EDA))

## Loading the Dataset

``` r
# Load dataset
GenderData <- read.csv("gender_classification_v7.csv", colClasses = c(
  long_hair = "factor",
  forehead_width_cm = "numeric",
  forehead_height_cm = "numeric",
  nose_wide = "factor",
  nose_long = "factor",
  lips_thin = "factor",
  distance_nose_to_lip_long = "factor",
  gender = "factor"
))

# Preview structure
str(GenderData)
```

    ## 'data.frame':    5001 obs. of  8 variables:
    ##  $ long_hair                : Factor w/ 2 levels "0","1": 2 1 1 1 2 2 2 1 2 2 ...
    ##  $ forehead_width_cm        : num  11.8 14 11.8 14.4 13.5 13 15.3 13 11.9 12.1 ...
    ##  $ forehead_height_cm       : num  6.1 5.4 6.3 6.1 5.9 6.8 6.2 5.2 5.4 5.4 ...
    ##  $ nose_wide                : Factor w/ 2 levels "0","1": 2 1 2 1 1 2 2 1 2 1 ...
    ##  $ nose_long                : Factor w/ 2 levels "0","1": 1 1 2 2 1 2 2 1 1 1 ...
    ##  $ lips_thin                : Factor w/ 2 levels "0","1": 2 2 2 2 1 2 2 1 2 1 ...
    ##  $ distance_nose_to_lip_long: Factor w/ 2 levels "0","1": 2 1 2 2 1 2 1 1 2 1 ...
    ##  $ gender                   : Factor w/ 2 levels "Female","Male": 2 1 2 2 1 2 2 1 1 1 ...

``` r
head(GenderData)
```

    ##   long_hair forehead_width_cm forehead_height_cm nose_wide nose_long lips_thin
    ## 1         1              11.8                6.1         1         0         1
    ## 2         0              14.0                5.4         0         0         1
    ## 3         0              11.8                6.3         1         1         1
    ## 4         0              14.4                6.1         0         1         1
    ## 5         1              13.5                5.9         0         0         0
    ## 6         1              13.0                6.8         1         1         1
    ##   distance_nose_to_lip_long gender
    ## 1                         1   Male
    ## 2                         0 Female
    ## 3                         1   Male
    ## 4                         1   Male
    ## 5                         0 Female
    ## 6                         1   Male

``` r
View(GenderData)
```

## Measures of Frequency

``` r
#Measures of Frequency
# Frequency of categorical variables
table(GenderData$gender)
```

    ## 
    ## Female   Male 
    ##   2501   2500

``` r
table(GenderData$long_hair)
```

    ## 
    ##    0    1 
    ##  652 4349

``` r
table(GenderData$nose_wide)
```

    ## 
    ##    0    1 
    ## 2531 2470

``` r
table(GenderData$nose_long)
```

    ## 
    ##    0    1 
    ## 2461 2540

``` r
table(GenderData$lips_thin)
```

    ## 
    ##    0    1 
    ## 2535 2466

``` r
table(GenderData$distance_nose_to_lip_long)
```

    ## 
    ##    0    1 
    ## 2506 2495

## Measures of Central Tendency

``` r
# Measures of Central Tendency
# Mean and median
mean(GenderData$forehead_width_cm)
```

    ## [1] 13.18148

``` r
median(GenderData$forehead_width_cm)
```

    ## [1] 13.1

``` r
mean(GenderData$forehead_height_cm)
```

    ## [1] 5.946311

``` r
median(GenderData$forehead_height_cm)
```

    ## [1] 5.9

``` r
# Mode function (since base R doesn't have one)
get_mode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

get_mode(GenderData$forehead_width_cm)
```

    ## [1] 12

``` r
get_mode(GenderData$forehead_height_cm)
```

    ## [1] 5.7

## Measures of Distribution

``` r
# Measures of Distribution
# Distribution metrics
sd(GenderData$forehead_width_cm)
```

    ## [1] 1.107128

``` r
range(GenderData$forehead_width_cm)
```

    ## [1] 11.4 15.5

``` r
IQR(GenderData$forehead_width_cm)
```

    ## [1] 1.8

``` r
sd(GenderData$forehead_height_cm)
```

    ## [1] 0.5412679

``` r
range(GenderData$forehead_height_cm)
```

    ## [1] 5.1 7.1

``` r
IQR(GenderData$forehead_height_cm)
```

    ## [1] 0.9

## Measures of Relationship

``` r
# Measures of Relationship
# Correlation between numeric variables
cor(GenderData$forehead_width_cm, GenderData$forehead_height_cm)
```

    ## [1] 0.08859643

``` r
# Chi-square test between categorical variables and gender
chisq.test(table(GenderData$long_hair, GenderData$gender))
```

    ## 
    ##  Pearson's Chi-squared test with Yates' continuity correction
    ## 
    ## data:  table(GenderData$long_hair, GenderData$gender)
    ## X-squared = 0.51755, df = 1, p-value = 0.4719

``` r
chisq.test(table(GenderData$nose_wide, GenderData$gender))
```

    ## 
    ##  Pearson's Chi-squared test with Yates' continuity correction
    ## 
    ## data:  table(GenderData$nose_wide, GenderData$gender)
    ## X-squared = 2874.2, df = 1, p-value < 2.2e-16

``` r
chisq.test(table(GenderData$nose_long, GenderData$gender))
```

    ## 
    ##  Pearson's Chi-squared test with Yates' continuity correction
    ## 
    ## data:  table(GenderData$nose_long, GenderData$gender)
    ## X-squared = 2766.4, df = 1, p-value < 2.2e-16

``` r
chisq.test(table(GenderData$lips_thin, GenderData$gender))
```

    ## 
    ##  Pearson's Chi-squared test with Yates' continuity correction
    ## 
    ## data:  table(GenderData$lips_thin, GenderData$gender)
    ## X-squared = 2760.2, df = 1, p-value < 2.2e-16

``` r
chisq.test(table(GenderData$distance_nose_to_lip_long, GenderData$gender))
```

    ## 
    ##  Pearson's Chi-squared test with Yates' continuity correction
    ## 
    ## data:  table(GenderData$distance_nose_to_lip_long, GenderData$gender)
    ## X-squared = 2846.5, df = 1, p-value < 2.2e-16

## ANOVA

``` r
# ANOVA for forehead_width_cm by gender
anova_fw <- aov(forehead_width_cm ~ gender, data = GenderData)
summary(anova_fw)
```

    ##               Df Sum Sq Mean Sq F value Pr(>F)    
    ## gender         1    684   684.2   628.2 <2e-16 ***
    ## Residuals   4999   5444     1.1                   
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
# ANOVA for forehead_height_cm by gender
anova_fh <- aov(forehead_height_cm ~ gender, data = GenderData)
summary(anova_fh)
```

    ##               Df Sum Sq Mean Sq F value Pr(>F)    
    ## gender         1  112.6  112.55   416.1 <2e-16 ***
    ## Residuals   4999 1352.3    0.27                   
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

## Plots

``` r
#Plots
library(ggplot2)

# Bar plots for categorical variables
ggplot(GenderData, aes(x = long_hair)) + 
  geom_bar(fill = "skyblue") + 
  ggtitle("Frequency of Long Hair")
```

![](gender_classification_files/figure-gfm/Plots-1.png)<!-- -->

``` r
ggplot(GenderData, aes(x = nose_wide)) + 
  geom_bar(fill = "tomato") + 
  ggtitle("Frequency of Wide Nose")
```

![](gender_classification_files/figure-gfm/Plots-2.png)<!-- -->

``` r
ggplot(GenderData, aes(x = lips_thin)) + 
  geom_bar(fill = "plum") + 
  ggtitle("Frequency of Thin Lips")
```

![](gender_classification_files/figure-gfm/Plots-3.png)<!-- -->

``` r
# Histograms for numeric variables
ggplot(GenderData, aes(x = forehead_width_cm)) + 
  geom_histogram(fill = "steelblue", bins = 15) + 
  ggtitle("Distribution of Forehead Width (cm)")
```

![](gender_classification_files/figure-gfm/Plots-4.png)<!-- -->

``` r
ggplot(GenderData, aes(x = forehead_height_cm)) + 
  geom_histogram(fill = "darkseagreen", bins = 15) + 
  ggtitle("Distribution of Forehead Height (cm)")
```

![](gender_classification_files/figure-gfm/Plots-5.png)<!-- -->

``` r
# Boxplots to compare numeric variables by gender
ggplot(GenderData, aes(x = gender, y = forehead_width_cm, fill = gender)) + 
  geom_boxplot() + 
  ggtitle("Forehead Width by Gender")
```

![](gender_classification_files/figure-gfm/Plots-6.png)<!-- -->

``` r
ggplot(GenderData, aes(x = gender, y = forehead_height_cm, fill = gender)) + 
  geom_boxplot() + 
  ggtitle("Forehead Height by Gender")
```

![](gender_classification_files/figure-gfm/Plots-7.png)<!-- -->

``` r
# Faceted bar plots for categorical features by gender
ggplot(GenderData, aes(x = long_hair, fill = gender)) + 
  geom_bar(position = "dodge") + 
  ggtitle("Long Hair by Gender")
```

![](gender_classification_files/figure-gfm/Plots-8.png)<!-- -->

``` r
ggplot(GenderData, aes(x = nose_long, fill = gender)) + 
  geom_bar(position = "dodge") + 
  ggtitle("Long Nose by Gender")
```

![](gender_classification_files/figure-gfm/Plots-9.png)<!-- -->

# Preprocessing & Data Transformation

## Missing Values

``` r
# Check for any missing values
anyNA(GenderData)
```

    ## [1] FALSE

``` r
# Count of missing values per column
colSums(is.na(GenderData))
```

    ##                 long_hair         forehead_width_cm        forehead_height_cm 
    ##                         0                         0                         0 
    ##                 nose_wide                 nose_long                 lips_thin 
    ##                         0                         0                         0 
    ## distance_nose_to_lip_long                    gender 
    ##                         0                         0

``` r
# Visual representation (optional)
library(Amelia)  # for missmap
```

    ## Loading required package: Rcpp

    ## ## 
    ## ## Amelia II: Multiple Imputation
    ## ## (Version 1.8.1, built: 2022-11-18)
    ## ## Copyright (C) 2005-2025 James Honaker, Gary King and Matthew Blackwell
    ## ## Refer to http://gking.harvard.edu/amelia/ for more information
    ## ##

``` r
missmap(GenderData, main = "Missing Values Map", col = c("yellow", "black"), legend = FALSE)
```

![](gender_classification_files/figure-gfm/Missing%20Values-1.png)<!-- -->

``` r
# Alternative visual with VIM
# install.packages("VIM") # Uncomment if not installed
library(VIM)
```

    ## Loading required package: colorspace

    ## Loading required package: grid

    ## The legacy packages maptools, rgdal, and rgeos, underpinning the sp package,
    ## which was just loaded, will retire in October 2023.
    ## Please refer to R-spatial evolution reports for details, especially
    ## https://r-spatial.org/r/2023/05/15/evolution4.html.
    ## It may be desirable to make the sf package available;
    ## package maintainers should consider adding sf to Suggests:.
    ## The sp package is now running under evolution status 2
    ##      (status 2 uses the sf package in place of rgdal)

    ## VIM is ready to use.

    ## Suggestions and bug-reports can be submitted at: https://github.com/statistikat/VIM/issues

    ## 
    ## Attaching package: 'VIM'

    ## The following object is masked from 'package:datasets':
    ## 
    ##     sleep

``` r
aggr(GenderData, col = c("navyblue", "red"), numbers = TRUE, sortVars = TRUE,
     labels = names(GenderData), cex.axis = .7, gap = 3,
     ylab = c("Missing Data", "Pattern"))
```

![](gender_classification_files/figure-gfm/Missing%20Values-2.png)<!-- -->

    ## 
    ##  Variables sorted by number of missings: 
    ##                   Variable Count
    ##                  long_hair     0
    ##          forehead_width_cm     0
    ##         forehead_height_cm     0
    ##                  nose_wide     0
    ##                  nose_long     0
    ##                  lips_thin     0
    ##  distance_nose_to_lip_long     0
    ##                     gender     0

# Training Models

## Data Splitting

``` r
# Load required library
library(caret)
```

    ## Loading required package: lattice

``` r
# Set seed for reproducibility
set.seed(123)

# Create a training and testing split (80% train, 20% test)
splitIndex <- createDataPartition(GenderData$gender, p = 0.8, list = FALSE)

# Create training and testing datasets
train_data <- GenderData[splitIndex, ]
test_data  <- GenderData[-splitIndex, ]

# Check the dimensions to confirm
cat("Training Data Size: ", nrow(train_data), "\n")
```

    ## Training Data Size:  4001

``` r
cat("Testing Data Size: ", nrow(test_data), "\n")
```

    ## Testing Data Size:  1000

## Bootstrapping

``` r
# Load required library
library(caret)

# Set seed for reproducibility
set.seed(123)

# Create bootstrap resampling with 1000 resamples
ctrl <- trainControl(method = "boot", number = 1000, savePredictions = "final")

# Train a logistic regression model using bootstrapping
boot_model <- train(gender ~ ., 
                    data = train_data, 
                    method = "glm", 
                    family = "binomial", 
                    trControl = ctrl, 
                    metric = "Accuracy")  # Use Accuracy for evaluation

# Print the model results
print(boot_model)
```

    ## Generalized Linear Model 
    ## 
    ## 4001 samples
    ##    7 predictor
    ##    2 classes: 'Female', 'Male' 
    ## 
    ## No pre-processing
    ## Resampling: Bootstrapped (1000 reps) 
    ## Summary of sample sizes: 4001, 4001, 4001, 4001, 4001, 4001, ... 
    ## Resampling results:
    ## 
    ##   Accuracy   Kappa    
    ##   0.9652292  0.9304306

``` r
# Check the resampling results
boot_results <- boot_model$resample
summary(boot_results)
```

    ##     Accuracy          Kappa          Resample        
    ##  Min.   :0.9517   Min.   :0.9034   Length:1000       
    ##  1st Qu.:0.9627   1st Qu.:0.9253   Class :character  
    ##  Median :0.9654   Median :0.9307   Mode  :character  
    ##  Mean   :0.9652   Mean   :0.9304                     
    ##  3rd Qu.:0.9679   3rd Qu.:0.9357                     
    ##  Max.   :0.9778   Max.   :0.9557

## Training Different Models

``` r
# Train a logistic regression model
logistic_model <- train(gender ~ ., 
                        data = train_data, 
                        method = "glm", 
                        family = "binomial", 
                        trControl = ctrl, 
                        metric = "Accuracy")  # Use Accuracy as the evaluation metric

# Print the results of the logistic regression model
print(logistic_model)
```

    ## Generalized Linear Model 
    ## 
    ## 4001 samples
    ##    7 predictor
    ##    2 classes: 'Female', 'Male' 
    ## 
    ## No pre-processing
    ## Resampling: Bootstrapped (1000 reps) 
    ## Summary of sample sizes: 4001, 4001, 4001, 4001, 4001, 4001, ... 
    ## Resampling results:
    ## 
    ##   Accuracy   Kappa    
    ##   0.9653343  0.9306423

``` r
# Train a Random Forest model with fewer trees
rf_model <- train(gender ~ ., 
                  data = train_data, 
                  method = "rf", 
                  trControl = ctrl, 
                  metric = "Accuracy", 
                  tuneGrid = expand.grid(mtry = 2),  # you can specify other mtry values here
                  ntree = 100)  # Reduce the number of trees


# Print the results of the random forest model
print(rf_model)
```

    ## Random Forest 
    ## 
    ## 4001 samples
    ##    7 predictor
    ##    2 classes: 'Female', 'Male' 
    ## 
    ## No pre-processing
    ## Resampling: Bootstrapped (1000 reps) 
    ## Summary of sample sizes: 4001, 4001, 4001, 4001, 4001, 4001, ... 
    ## Resampling results:
    ## 
    ##   Accuracy  Kappa    
    ##   0.970743  0.9414637
    ## 
    ## Tuning parameter 'mtry' was held constant at a value of 2

## Performance Comparison Using Resamples

``` r
# Load caret package if not already loaded
library(caret)

# Compare model performance
model_results <- resamples(list(
  Logistic = logistic_model,
  RandomForest = rf_model
))

# Summary of the comparison
summary(model_results)
```

    ## 
    ## Call:
    ## summary.resamples(object = model_results)
    ## 
    ## Models: Logistic, RandomForest 
    ## Number of resamples: 1000 
    ## 
    ## Accuracy 
    ##                   Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NA's
    ## Logistic     0.9541029 0.9625237 0.9654354 0.9653343 0.9680761 0.9783345    0
    ## RandomForest 0.9582210 0.9681572 0.9709303 0.9707430 0.9733970 0.9823370    0
    ## 
    ## Kappa 
    ##                   Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NA's
    ## Logistic     0.9081034 0.9250292 0.9308695 0.9306423 0.9361427 0.9566692    0
    ## RandomForest 0.9164226 0.9363063 0.9418397 0.9414637 0.9467768 0.9646739    0

``` r
# Boxplots to visualize accuracy and kappa
bwplot(model_results, metric = "Accuracy")
```

![](gender_classification_files/figure-gfm/resamples-1.png)<!-- -->

``` r
bwplot(model_results, metric = "Kappa")
```

![](gender_classification_files/figure-gfm/resamples-2.png)<!-- -->

``` r
# Dotplots as alternative visualization
dotplot(model_results, metric = "Accuracy")
```

![](gender_classification_files/figure-gfm/resamples-3.png)<!-- -->

## Saving Model

``` r
# Save the best performing model
saveRDS(rf_model, "models/saved_rf_model.rds")

# Load the saved model
loaded_rf_model <- readRDS("models/saved_rf_model.rds")

# Example new data for prediction (update with actual values as needed)
new_data <- data.frame(
  long_hair = factor(1, levels = levels(GenderData$long_hair)),
  forehead_width_cm = 13.5,
  forehead_height_cm = 6.2,
  nose_wide = factor(0, levels = levels(GenderData$nose_wide)),
  nose_long = factor(1, levels = levels(GenderData$nose_long)),
  lips_thin = factor(0, levels = levels(GenderData$lips_thin)),
  distance_nose_to_lip_long = factor(1, levels = levels(GenderData$distance_nose_to_lip_long))
)

# Make prediction
prediction <- predict(loaded_rf_model, newdata = new_data)

# Print prediction
print(prediction)
```

    ## [1] Female
    ## Levels: Female Male
