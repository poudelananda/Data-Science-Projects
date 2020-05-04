# Reads in the data for each month

january <- read.csv("Data/january_iphone_q.csv")
february <- read.csv("Data/february_iphone_q.csv")
march <- read.csv("Data/march_iphone_q.csv")
april <- read.csv("Data/april_iphone_q.csv")
may <- read.csv("Data/may_iphone_q.csv")
june <- read.csv("Data/june_iphone_q.csv")
july <- read.csv("Data/july_iphone_q.csv")
august <- read.csv("Data/august_iphone_q.csv")
september <- read.csv("Data/september_iphone_q.csv")
october <- read.csv("Data/october_iphone_q.csv")
november <- read.csv("Data/november_iphone_q.csv")
december <- read.csv("Data/december_iphone_q.csv")

# Combines all of the months into a list
months <- list(january, february, march, april, may, june, july, 
                  august, september, october, november, december)