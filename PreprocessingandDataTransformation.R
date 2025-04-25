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

# Preview structure
str(GenderData)
head(GenderData)
View(GenderData)

# Check for any missing values
anyNA(GenderData)

# Count of missing values per column
colSums(is.na(GenderData))

# Visual representation (optional)
library(Amelia)  # for missmap
missmap(GenderData, main = "Missing Values Map", col = c("yellow", "black"), legend = FALSE)

# Alternative visual with VIM
# install.packages("VIM") # Uncomment if not installed
library(VIM)
aggr(GenderData, col = c("navyblue", "red"), numbers = TRUE, sortVars = TRUE,
     labels = names(GenderData), cex.axis = .7, gap = 3,
     ylab = c("Missing Data", "Pattern"))

