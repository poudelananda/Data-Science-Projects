# Downloads the required libraries
source("Src/library.r")

# Reads in, cleans the data, and puts it into a list called month
source("Src/import_clean_data.R")

# Reads in stop words, and has the function to run LDA
source("Src/myLDA.R")

num_datasets <- length(months)

for (i in 1:num_datasets) {
  
  if (i == 6) {
    
    final_labels <- LDA(data.frame(months[[i]]), "text", 10, 2)
    write.csv(final_labels, concatenate("Output/", as.character(i),".csv", collapse = ""))
    
  } else if (nrow(months[[i]]) < 10){
    
    final_labels <- LDA(data.frame(months[[i]]), "text", 10, 2)
    write.csv(final_labels, concatenate("Output/", as.character(i),".csv", collapse = ""))
    
  } else {
    
    labels <- data.frame("labels" = rep(0, nrow(months[[i]])))
    labels <- splitLDA(data.frame(months[[i]]), "text")
    final_labels <- LDA(labels, "labels", 10, 2)
    write.csv(final_labels, concatenate("Output/", as.character(i),".csv", collapse = ""))
  }
    
}
