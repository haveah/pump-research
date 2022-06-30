

library(dplyr)
library(wordcloud)
library(tidytext)
library(RColorBrewer)

mentee_data <- read.csv("csv files/Mentee Survey Data.csv", stringsAsFactors = F)

# Themes in the response “what is your primary reason for seeking a psychology mentor?”
simplified <- data.frame(mentee_data$Name, mentee_data$With.which.gender.do.you.identify., mentee_data$Select.all.of.the.following.groups.with.which.you.identify., mentee_data$Do.you.identify.as.belonging.to.the.LGBTQ..community., mentee_data$What.is.your.primary.reason.for.seeking.a.psychology.mentor.)

colnames(simplified)[1] <- c("name")
colnames(simplified)[2] <- c("gender_identity")
colnames(simplified)[3] <- c("ethnicity")
colnames(simplified)[4] <- c("lgbtq")
colnames(simplified)[5] <- c("reason_for_mentor")



simplified_text <- tibble(text = simplified$reason_for_mentor) %>%
  unnest_tokens(output = word,
                input = text) %>%
  count(word)

mystopwords <- data.frame(c("winter", "chinese", "world", "mentors", "child", "american", "online", "medicine", "deep", "seek", "i've", "i'm", "i'd", "pre", "uw's", "it's", "lot", "set", "informationn", "bit", "post", "bit", "act", "fall", "mine"))
colnames(mystopwords)[1] <- c("word")

stop_words <- dplyr::bind_rows(stop_words, mystopwords)


themes_for_mentorship <- anti_join(simplified_text, stop_words, by = "word", copy = F)
themes_for_mentorship <- themes_for_mentorship[-c(146, 147), ]


wordcloud::wordcloud(words = themes_for_mentorship$word,
                     freq = themes_for_mentorship$n,
                     random.order = F,
                     scale = c(3.5, 0.5),
                     min.freq = 2,
                     max.words = 100,
                     colors = c("#1e81b0",
                                "#e28743",
                                "#e28743",
                                "#eab676"))


