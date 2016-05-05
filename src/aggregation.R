dir = ""
setwd(dir)
library(dplyr)
rating.data <- read.csv("data.csv", header = T)
n1 <- length(levels(rating.data$add_13_sentences_to_add_to_the_story_))
submissions <- levels(rating.data$add_13_sentences_to_add_to_the_story_)
scores <- data.frame()
for (i in 1:n1) {
  new.page <- filter(rating.data, add_13_sentences_to_add_to_the_story_ == submissions[i])
  appr.avg <- mean(new.page$rate_the_story_based_on_the_example_above_inappropriateappropriate_for_ages_37)
  if (appr.avg >= 3.5) {
    interest <- mean(new.page$rate_the_story_based_on_the_example_above_boringinteresting)
    relevance <- mean(new.page$rate_the_story_based_on_the_example_above_irrelevantrelevant)
    thought.provoking <- mean(new.page$rate_the_story_based_on_the_example_above_notthoughtprovokingthoughtprovoking)
    readability <- mean(new.page$rate_the_story_based_on_the_example_above_incomprehensiblereadability)
    total <- interest + relevance + thought.provoking + readability
    row <- cbind(total, submissions[i])
    scores <- rbind(scores, row)
  }
}
winner <- which.max(scores$total)
next.page <- scores$V2[winner]
new.story <- paste(rating.data$story[1], next.page)

