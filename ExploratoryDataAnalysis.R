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

#Measures of Frequency
# Frequency of categorical variables
table(GenderData$gender)
table(GenderData$long_hair)
table(GenderData$nose_wide)
table(GenderData$nose_long)
table(GenderData$lips_thin)
table(GenderData$distance_nose_to_lip_long)

# Measures of Central Tendency
# Mean and median
mean(GenderData$forehead_width_cm)
median(GenderData$forehead_width_cm)

mean(GenderData$forehead_height_cm)
median(GenderData$forehead_height_cm)

# Mode function (since base R doesn't have one)
get_mode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

get_mode(GenderData$forehead_width_cm)
get_mode(GenderData$forehead_height_cm)

# Measures of Distribution
# Distribution metrics
sd(GenderData$forehead_width_cm)
range(GenderData$forehead_width_cm)
IQR(GenderData$forehead_width_cm)

sd(GenderData$forehead_height_cm)
range(GenderData$forehead_height_cm)
IQR(GenderData$forehead_height_cm)

# Measures of Relationship
# Correlation between numeric variables
cor(GenderData$forehead_width_cm, GenderData$forehead_height_cm)

# Chi-square test between categorical variables and gender
chisq.test(table(GenderData$long_hair, GenderData$gender))
chisq.test(table(GenderData$nose_wide, GenderData$gender))
chisq.test(table(GenderData$nose_long, GenderData$gender))
chisq.test(table(GenderData$lips_thin, GenderData$gender))
chisq.test(table(GenderData$distance_nose_to_lip_long, GenderData$gender))

# ANOVA for forehead_width_cm by gender
anova_fw <- aov(forehead_width_cm ~ gender, data = GenderData)
summary(anova_fw)

# ANOVA for forehead_height_cm by gender
anova_fh <- aov(forehead_height_cm ~ gender, data = GenderData)
summary(anova_fh)

#Plots
library(ggplot2)

# Bar plots for categorical variables
ggplot(GenderData, aes(x = long_hair)) + 
  geom_bar(fill = "skyblue") + 
  ggtitle("Frequency of Long Hair")

ggplot(GenderData, aes(x = nose_wide)) + 
  geom_bar(fill = "tomato") + 
  ggtitle("Frequency of Wide Nose")

ggplot(GenderData, aes(x = lips_thin)) + 
  geom_bar(fill = "plum") + 
  ggtitle("Frequency of Thin Lips")

# Histograms for numeric variables
ggplot(GenderData, aes(x = forehead_width_cm)) + 
  geom_histogram(fill = "steelblue", bins = 15) + 
  ggtitle("Distribution of Forehead Width (cm)")

ggplot(GenderData, aes(x = forehead_height_cm)) + 
  geom_histogram(fill = "darkseagreen", bins = 15) + 
  ggtitle("Distribution of Forehead Height (cm)")


# Boxplots to compare numeric variables by gender
ggplot(GenderData, aes(x = gender, y = forehead_width_cm, fill = gender)) + 
  geom_boxplot() + 
  ggtitle("Forehead Width by Gender")

ggplot(GenderData, aes(x = gender, y = forehead_height_cm, fill = gender)) + 
  geom_boxplot() + 
  ggtitle("Forehead Height by Gender")

# Faceted bar plots for categorical features by gender
ggplot(GenderData, aes(x = long_hair, fill = gender)) + 
  geom_bar(position = "dodge") + 
  ggtitle("Long Hair by Gender")

ggplot(GenderData, aes(x = nose_long, fill = gender)) + 
  geom_bar(position = "dodge") + 
  ggtitle("Long Nose by Gender")

