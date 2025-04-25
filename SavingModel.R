# Create models directory if it doesn't exist
if (!dir.exists("models")) dir.create("models")

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
