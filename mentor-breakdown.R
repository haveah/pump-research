
library(knitr)

mentor <- read.csv("csv files/Mentor Info.csv", stringsAsFactors = F)

# Total number of undergraduates participating (both mentors and mentees) with breakdown by year; total numbers of graduate students, faculty, and other categories
mentor_breakdown = table(mentor$Year)

knitr::kable(mentor_breakdown, col.names = c("Standing", "Amount"))