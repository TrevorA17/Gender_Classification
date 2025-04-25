# Load dataset
GenderData <- read.csv("data/gender_classification_v7.csv", colClasses = c(
  long_hair = "factor",
  forehead_width_cm = "numeric",
  forehead_height_cm = "numeric",
  nose_wide = "factor",
  nose_long = "factor",
  lips_thin = "factor",
  distance_nose_to_lip_long = "factor",
  gender = "factor"
))

# Load required library
library(caret)

# Set seed for reproducibility
set.seed(123)

# Create a training and testing split (80% train, 20% test)
splitIndex <- createDataPartition(GenderData$gender, p = 0.8, list = FALSE)

# Create training and testing datasets
train_data <- GenderData[splitIndex, ]
test_data  <- GenderData[-splitIndex, ]

# Check the dimensions to confirm
cat("Training Data Size: ", nrow(train_data), "\n")
cat("Testing Data Size: ", nrow(test_data), "\n")

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

# Check the resampling results
boot_results <- boot_model$resample
summary(boot_results)

# Train a logistic regression model
logistic_model <- train(gender ~ ., 
                        data = train_data, 
                        method = "glm", 
                        family = "binomial", 
                        trControl = ctrl, 
                        metric = "Accuracy")  # Use Accuracy as the evaluation metric

# Print the results of the logistic regression model
print(logistic_model)

# Train a Random Forest model
rf_model <- train(gender ~ ., 
                  data = train_data, 
                  method = "rf", 
                  trControl = ctrl, 
                  metric = "Accuracy")  # Use Accuracy for performance evaluation

# Print the results of the random forest model
print(rf_model)

