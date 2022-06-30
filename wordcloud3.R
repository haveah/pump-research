
library(dplyr)
library(wordcloud)
library(tidytext)
library(RColorBrewer)

df_two <- read.csv("csv files/Sample Participant Responses - Sheet1.csv", stringsAsFactors = F)


# Themes to the question “What have you learned from your mentor?”
simplified_two <- data.frame(df_two$Last.name, df_two$Are.you.interested.in.continuing.to.be.mentored.by.this.person.next.academic.year., df_two$Are.you.interested.in.continuing.as.a.mentee.in.this.program.with.a.different.mentor.next.academic.year., df_two$Are.you.interested.in.being.a.mentor.for.a.first..or.second.year.student.in.the.coming.academic.year..2022.23.., df_two$People.can.seek.mentorship.relationships.for.a.variety.of.reasons..Some.have.a.desire.to.connect.with.others.with.a.shared.identity..others.are.interested.in.connecting.with.others.with.shared.interests..others.are.looking.for.friendship..camaraderie..and.community.with.people.who.have.a.similar.personality..Which.of.these.reasons..or.another.reason..best.describes.your.reason.for.participating.in.this.program., df_two$What.have.you.learned.from.your.mentor.)

colnames(simplified_two)[1] <- c("name")
colnames(simplified_two)[2] <- c("same_mentor")
colnames(simplified_two)[3] <- c("different_mentor")
colnames(simplified_two)[4] <- c("becoming_mentor")
colnames(simplified_two)[5] <- c("reason_for_mentor")
colnames(simplified_two)[6] <- c("learned_from_mentor")

learned_text <- tibble(text = simplified_two$learned_from_mentor) %>%
  unnest_tokens(output = word,
                input = text) %>%
  count(word)

mystopwords <- data.frame(c("winter", "chinese", "world", "mentors", "child", "american", "online", "medicine", "deep", "seek", "i've", "i'm", "i'd", "pre", "uw's", "it's", "lot", "set", "informationn", "bit", "post", "bit", "act", "fall", "mine"))
colnames(mystopwords)[1] <- c("word")

stop_words <- dplyr::bind_rows(stop_words, mystopwords)

learned_lessons <- anti_join(learned_text, stop_words, by = "word", copy = F)
learned_lessons <- learned_lessons[-c(37, 42), ]

wordcloud::wordcloud(words = learned_lessons$word,
                     freq = learned_lessons$n,
                     random.order = F,
                     scale = c(3.5, 0.5),
                     min.freq = 1,
                     max.words = 100,
                     colors = c("#69569C",
                                "#AF91D0",
                                "#F34F19",
                                "#F34F19"))