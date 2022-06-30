
library(dplyr)
library(ggplot2)

df_two <- read.csv("csv files/Sample Participant Responses - Sheet1.csv", stringsAsFactors = F)

# Means and a graph of responses to: “How has your mentoring relationship impacted your feelings of belonging in the UW Department of Psychology?”
impacted_belonging <- data.frame(df_two$Last.name, df_two$How.has.your.mentoring.relationship.impacted.your.feelings.of.belonging.in.the.UW.Department.of.Psychology.)

colnames(impacted_belonging)[1] <- c("name")
colnames(impacted_belonging)[2] <- c("belonging_psych_department")
  
impacted_belonging[c('Scale', 'Meaning')] <- str_split_fixed(impacted_belonging$belonging_psych_department, ' ', 2)

impacted_belonging <- tibble(text = impacted_belonging$Scale) %>%
  unnest_tokens(output = scale,
                input = text) %>%
  count(scale)

added_scale <- data.frame(scale = c(1, 2),
                             n = c(0, 0))

complete_scale <- rbind(added_scale, impacted_belonging)

complete_scale %>%
  ggplot(aes(x = scale,
             y = n)) +
  geom_col() +
  labs(x = "Scale", y = "Number of Responses")
  
