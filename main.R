## Runs the blah blah blah

rm(list = ls())
# Downloads the required libraries
source("Src/library.r")

# Reads in, cleans the data, and puts it into a list called month
source("Src/import_clean_data.R")

# Reads in stop words, and has the function to run LDA
source("Src/myLDA.R")

# Has function to build frequency tables
source("Src/build_frequency_table.R")

# --------------------------------------------------------------------------------------------------
## Next chunk finds the topics for all the data

# Empty list that will contain all of the topics for each month
topics <- list()
scores <- list()
# Number of months
num_datasets <- length(months)

# Goes through all of the datasets and runs LDA on it
for (i in 1:num_datasets) {
  
  # For June, since splitLDA doesn't work on it
  if (i == 6) {
    
    # Runs the LDA function from Src/myLDA 
    lda_results <- LDA(data.frame(months[[i]]), "text", 10, 2)
    
    # Get the top 10 topics
    final_labels <- lda_results[1]
    
    # Get the coherence scores
    score <- lda_results[2]
    
    # Adds the topics to the topic list
    name <- concatenate("month", i, "Topics", collapse = "")
    topics[[name]] <- append(topics, final_labels)
    
    # Adds the scores to the scores list
    name <- concatenate("month", i, "Scores", collapse = "")
    scores[[name]] <- append(scores, score)
    
    # Builds a CSV with the topics and another one for the scores
    write.csv(final_labels, concatenate("Output/", "month", as.character(i),".csv", collapse = ""))
    write.csv(score, concatenate("Output/", "month", as.character(i),"score.csv", collapse = ""))
    
  # For months that have less than 10 observations
  } else if (nrow(months[[i]]) < 10) {
    
    # Runs the LDA function from Src/myLDA to get 10 topics
    lda_results <- LDA(data.frame(months[[i]]), "text", nrow(months[[i]]), 2)
    
    # Get the topics
    final_labels <- lda_results[1]
    
    # Get the coherence scores
    score <- lda_results[2]
    
    # Adds the topics to the topic list
    name <- concatenate("month", i, "Topics", collapse = "")
    topics[[name]] <- append(topics, final_labels)
    
    # Adds the scores to the scores list
    name <- concatenate("month", i, "Scores", collapse = "")
    scores[[name]] <- append(scores, score)
    
    # Builds a CSV with the topics and another one for the scores
    write.csv(final_labels, concatenate("Output/", "month", as.character(i),".csv", collapse = ""))
    write.csv(score, concatenate("Output/", "month", as.character(i),"score.csv", collapse = ""))
    
  # For all other months
  } else {
    
    # Runs the first iteration of LDA to get topics for each observations
    labels <- data.frame("labels" = rep(0, nrow(months[[i]])))
    labels <- splitLDA(data.frame(months[[i]]), "text")
    
    # Runs the second iteration of LDA to get the 10 most popular topics
    lda_results <- LDA(labels, "labels", 10, 2)
    final_labels <- lda_results[1]
    
    # Get the coherence scores
    score <- lda_results[2]
    
    # Adds the topics to the topic list
    name <- concatenate("month", i, "Topics", collapse = "")
    topics[[name]] <- append(topics, final_labels)
    
    # Adds the scores to the scores list
    name <- concatenate("month", i, "Scores", collapse = "")
    scores[[name]] <- append(scores, score)
    
    # Builds a CSV with the topics and an additional one for scores
    write.csv(final_labels, concatenate("Output/", "month", as.character(i),".csv", collapse = ""))
    write.csv(score, concatenate("Output/", "month", as.character(i),"score.csv", collapse = ""))
  }
  
}

# --------------------------------------------------------------------------------------------------
## Last chunk gets frequencies

# Finds frequency tables for each month
for (i in 1:length(months)) {
  
  # Uses the build_frequency_table() function from Src/build_frequency_table
  table <- build_frequency_table(months[[i]])
  
  # Builds a CSV with the frequency tables
  write.csv(table, concatenate("Output/", "month", as.character(i), "freq_table.csv", collapse = ""))
}

