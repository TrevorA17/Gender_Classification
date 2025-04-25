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