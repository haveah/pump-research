

library(ggplot2)

mentee <- read.csv("csv files/Mentee Info.csv", stringsAsFactors = F)

# Pie chart visualizing the areas of interest of mentees
area_interest <- data.frame(
  area_interest = c("Behavioral Neuroscience/Biological Psychology", "Cognition and Perception", "Developmental Psychology", "Forensic Psychology", "Health Psychology", "Industrial/Organizational Psychology", "Social and Personality Psychology", "Clinical Psychology", "Counseling Psychology", "Cultural Psychology", "Educational Psychology/School Psychology", "Quantitative Psychology and Experimental Methods", "Animal Behavior", "Cognitive Neuroscience", "Computational Neuroscience", "Cognitive Science", "Child/Family Counseling", "Sports Psychology", "Business Psychology", "Criminal Psychology", "Psychology Nurse", "Adolescent Psychology", "Psychiatry"),
  value = c(15, 16, 22, 8, 13, 7, 26, 25, 32, 14, 14, 1, 2, 1, 1, 1, 2, 6, 1, 1, 1, 1, 1)
)

ggplot(area_interest, aes(x = "", y = value, fill = area_interest)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  geom_text(aes(label = paste0(value)), position = position_stack(vjust = 0.5)) +
  labs(x = NULL, y = NULL, fill = NULL) +
  theme_classic() + 
  theme(axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust = 1))