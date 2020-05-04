source("Src/library.R")

build_frequency_table <- function(data) {
  
  text <- str("")
  
  for (i in 1:nrow(data)) {
    text <- concatenate(text, data[i, 3])
  }
  
  text <- preprocess(text, remove.punct = TRUE)
  
  text_new <- qdap::rm_stopwords(text, 
                                 stopwords = c(qdapDictionaries::Top100Words, a_stopwords))
  clean_text <- str("")
  for (i in 1:length(text_new[[1]])) {
    clean_text <- concatenate(clean_text, text_new[[1]][i])
  }
  
  ng <- ngram(clean_text, n=2)
  freq_table <- get.phrasetable(ng)
  return(freq_table)
}


