apple_stopwords <- read.csv("Data/apple_stopwords.csv", header = FALSE)
a_stopwords <- as.character(apple_stopwords$V1)
#apple_stop <- c(a_stopwords, stopwords("en"), stopwords(source = "smart"))

LDA <- function(month_data, var_name, num_topics = 1, end_window = 5) {
  
  num_rows <- nrow(month_data)
  dtm <- CreateDtm(month_data[[var_name]], doc_names = 1:num_rows, ngram_window = c(1, end_window),
                   stopword_vec = c(stopwords::stopwords("en"),
                                    stopwords::stopwords(source = "smart"),
                                    a_stopwords))
  
  #looking at terms that appear more than 2 times in the document and getting rid of no entries
#  dtm <- dtm[rowSums(dtm) > 1, colSums(dtm) > 2] 
  
  #the term frequency within that document
  tf <- TermDocFreq(dtm)
  
  set.seed(12345)
  #fit into a lda model and calculate the coherence score of each terms.
  fit <- FitLdaModel(dtm = dtm, k = num_topics, iterations = 200, calc_coherence = TRUE)
  
  #Theta gives the probability of a certain topic appearing in a certain document
  fit$labels <- LabelTopics(assignments = fit$theta > 0.05, dtm = dtm, M = 1)
  
  information <- list("labels" = fit$labels, "coherence" = fit$coherence)
  
  return(information)
  
}

splitLDA <- function(month_data, var_name) {
  num_rows <- nrow(month_data)
  idx <- floor(num_rows/10)
  for (i in 1:idx) {
    start_idx <- ((i*10) - 9)
    end_idx <- (i*10)
    temp_data <- month_data[start_idx:end_idx,]
    labels[start_idx:end_idx,] <- LDA(data.frame(temp_data), var_name)[1]
  }
  
  remainder <- num_rows%%10
  if  (remainder != 0) {
    start_idx <- num_rows - remainder + 1
    end_idx <- num_rows
    temp_data <- october[start_idx:end_idx,]
    labels[start_idx:end_idx,] <- LDA(data.frame(temp_data), var_name)[1]
  }
  
  return(labels)
}