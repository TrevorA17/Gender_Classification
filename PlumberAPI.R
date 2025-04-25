# plumber.R

# Load necessary library
library(plumber)

# Load the saved Random Forest model
loaded_rf_model <- readRDS("models/saved_rf_model.rds")

#* @apiTitle Gender Classification API
#* @apiDescription Predicts gender based on facial features.

#* @param long_hair Is the hair long? (0 or 1)
#* @param forehead_width_cm Width of the forehead (numeric)
#* @param forehead_height_cm Height of the forehead (numeric)
#* @param nose_wide Is the nose wide? (0 or 1)
#* @param nose_long Is the nose long? (0 or 1)
#* @param lips_thin Are the lips thin? (0 or 1)
#* @param distance_nose_to_lip_long Is the distance from nose to lip long? (0 or 1)

#* @get /predict_gender
function(long_hair, forehead_width_cm, forehead_height_cm, nose_wide,
         nose_long, lips_thin, distance_nose_to_lip_long) {
  
  # Construct data frame with correct types and factor levels
  input_data <- data.frame(
    long_hair = factor(as.integer(long_hair), levels = levels(GenderData$long_hair)),
    forehead_width_cm = as.numeric(forehead_width_cm),
    forehead_height_cm = as.numeric(forehead_height_cm),
    nose_wide = factor(as.integer(nose_wide), levels = levels(GenderData$nose_wide)),
    nose_long = factor(as.integer(nose_long), levels = levels(GenderData$nose_long)),
    lips_thin = factor(as.integer(lips_thin), levels = levels(GenderData$lips_thin)),
    distance_nose_to_lip_long = factor(as.integer(distance_nose_to_lip_long), levels = levels(GenderData$distance_nose_to_lip_long))
  )
  
  # Make prediction
  prediction <- predict(loaded_rf_model, newdata = input_data)
  
  # Return prediction
  list(predicted_gender = as.character(prediction))
}
