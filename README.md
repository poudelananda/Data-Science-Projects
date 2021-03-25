# Topic-Modeling-NLP
This project is for a client called Ozmo, located in Blacksburg, VA.
Four members were involved in this project.
The main goal of the project was to make sure that we identified the proper topics from the text data which was webscraped from apple forums and identify time intervals for those topics. 
Latent Dirichlet Allocation, a topic modeling algorithm, was used to create the model. The LDA algorithm ran on each forum question and classified each question as a topic. Then another LDA model was ran on all the topics we received from the first model to receive the most prevalent topics in the data set. This approach seemed to give us more accurate results as checked by the frequencies. 
Only way we could validate the dataset was by looking at the coherence score and setting up the frequency table to see the distinct words that came up throughout the document that caused to create a topic.
Overall, the data showed no long term trends in the analysis and most of the significant topics were only relevant for a month.
