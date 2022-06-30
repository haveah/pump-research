
library(dplyr)
library(tidytext)
library(stringr)
library(ggplot2)
library(knitr)

# Sample Dateset 1
mentee <- read.csv("csv files/Mentee Info.csv", stringsAsFactors = F)
mentee_data <- read.csv("csv files/Mentee Survey Data.csv", stringsAsFactors = F)
mentor <- read.csv("csv files/Mentor Info.csv", stringsAsFactors = F)



# Total number of undergraduates participating (both mentors and mentees) with breakdown by year; total numbers of graduate students, faculty, and other categories
undergraduate_mentee <- nrow(mentee)
undergraduates <- undergraduate_mentee + 10 + 13 + 5


# Percentage of mentees that belong to each gender identity and each underrepresented identity category
simplified <- data.frame(mentee_data$Name, mentee_data$With.which.gender.do.you.identify., mentee_data$Select.all.of.the.following.groups.with.which.you.identify., mentee_data$Do.you.identify.as.belonging.to.the.LGBTQ..community., mentee_data$What.is.your.primary.reason.for.seeking.a.psychology.mentor.)

colnames(simplified)[1] <- c("name")
colnames(simplified)[2] <- c("gender_identity")
colnames(simplified)[3] <- c("ethnicity")
colnames(simplified)[4] <- c("lgbtq")
colnames(simplified)[5] <- c("reason_for_mentor")

gender_identity <- tibble(text = simplified$gender_identity) %>%
  unnest_tokens(output = gender,
                input = text) %>%
  count(gender)
gender_identity <- gender_identity[-c(1), ]

male <- as.numeric(gender_identity[2, 2])
male_percentage <- (male / undergraduate_mentee) * 100

non_binary <- as.numeric(gender_identity[3, 2])
non_binary_percentage <- (non_binary / undergraduate_mentee) * 100

female <- as.numeric(gender_identity[1, 2])
female_percentage <- (female / undergraduate_mentee) * 100




ethnicity <- tibble(text = simplified$ethnicity) %>%
  unnest_tokens(output = ethnicity,
                input = text) %>%
  count(ethnicity)

african_american <- as.numeric(ethnicity[1, 2])
aa_percentage <- (african_american / undergraduate_mentee) * 100

east_asian <- as.numeric(ethnicity[2, 2])
ea_percentage <- (east_asian / undergraduate_mentee) * 100

filipino <- as.numeric(ethnicity[3, 2])
filipino_percentage <- (filipino / undergraduate_mentee) * 100

latinx <- as.numeric(ethnicity[4, 2])
lx_percentage <- (latinx / undergraduate_mentee) * 100

middle_eastern <- as.numeric(ethnicity[5, 2])
me_percentage <- (middle_eastern / undergraduate_mentee) * 100

south_asian <- as.numeric(ethnicity[6, 2])
sa_percentage <- (south_asian / undergraduate_mentee) * 100

south_east_asian <- as.numeric(ethnicity[7, 2])
sea_percentage <- (south_east_asian / undergraduate_mentee) * 100

white <- as.numeric(ethnicity[8, 2])
white_percentage <- (white / undergraduate_mentee) * 100




lgbtq <- tibble(text = simplified$lgbtq) %>%
  unnest_tokens(output = lgbtq,
                input = text) %>%
  count(lgbtq)
lgbtq <- lgbtq[-c(3, 4, 6, 7), ]

fgcs <- as.numeric(lgbtq[1, 2])
fgcs_percentage <- (fgcs / undergraduate_mentee) * 100

queer <- as.numeric(lgbtq[3, 2])
queer_percentage <- (queer / undergraduate_mentee) * 100



# Sample Dataset 2
df_two <- read.csv("csv files/Sample Participant Responses - Sheet1.csv", stringsAsFactors = F)
simplified_two <- data.frame(df_two$Last.name, df_two$Are.you.interested.in.continuing.to.be.mentored.by.this.person.next.academic.year., df_two$Are.you.interested.in.continuing.as.a.mentee.in.this.program.with.a.different.mentor.next.academic.year., df_two$Are.you.interested.in.being.a.mentor.for.a.first..or.second.year.student.in.the.coming.academic.year..2022.23.., df_two$People.can.seek.mentorship.relationships.for.a.variety.of.reasons..Some.have.a.desire.to.connect.with.others.with.a.shared.identity..others.are.interested.in.connecting.with.others.with.shared.interests..others.are.looking.for.friendship..camaraderie..and.community.with.people.who.have.a.similar.personality..Which.of.these.reasons..or.another.reason..best.describes.your.reason.for.participating.in.this.program., df_two$What.have.you.learned.from.your.mentor.)

colnames(simplified_two)[1] <- c("name")
colnames(simplified_two)[2] <- c("same_mentor")
colnames(simplified_two)[3] <- c("different_mentor")
colnames(simplified_two)[4] <- c("becoming_mentor")
colnames(simplified_two)[5] <- c("reason_for_mentor")
colnames(simplified_two)[6] <- c("learned_from_mentor")

# People who are interested in continuing with the same mentor
same_mentor <- simplified_two %>%
  select(name, same_mentor) %>%
  filter(same_mentor == "Yes")

same_mentor <- same_mentor[, 1]


maybe_same_mentor <- simplified_two %>%
  select(name, same_mentor) %>%
  filter(same_mentor == "Maybe/Not sure")

maybe_same_mentor <- maybe_same_mentor[, 1]

# People who need to be rematched with a new mentor
rematch_mentor <- simplified_two %>%
  select(name, different_mentor) %>%
  filter(different_mentor == "Yes")

rematch_mentor <- rematch_mentor[, 1]

maybe_rematch_mentor <- simplified_two %>%
  select(name, different_mentor) %>%
  filter(different_mentor == "Maybe/Not sure yet")

maybe_rematch_mentor <- maybe_rematch_mentor[, 1]

# People who want to become a mentor next year
become_mentor <- simplified_two %>%
  select(name, becoming_mentor) %>%
  filter(becoming_mentor == "Yes")

become_mentor <- become_mentor[, 1]

possible_mentor <- simplified_two %>%
  select(name, becoming_mentor) %>%
  filter(becoming_mentor == "Maybe/Not sure yet")

possible_mentor <- possible_mentor[, 1]


