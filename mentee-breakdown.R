
library(knitr)

mentee <- read.csv("csv files/Mentee Info.csv", stringsAsFactors = F)


# Total number of undergraduates participating (both mentors and mentees) with breakdown by year; total numbers of graduate students, faculty, and other categories
mentee_breakdown = table(mentee$Year)

knitr::kable(mentee_breakdown, col.names = c("Class Standing", "Amount"))
