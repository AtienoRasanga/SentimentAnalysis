#
skills <- read.csv("C:/Users/Fiona/Desktop/Business Analytics and Decision Sciences/Forecasting and Business Analytics/FABA-L9-Notes/skills.csv", header= TRUE, stringsAsFactors = FALSE)
# The argument stringsAsFactors=FALSE keeps the text as a character type

# Next let's explore the data:
head(skills)
summary(skills)

# Let's install and add the tm package to your R library:
#install.packages("tm")
library(tm)

# Now we can convert our data to a document term matrix which reflects the number of times each token (word) is used.
# First we convert the data to a corpus (a collection of documents containing text in the same format) using: 
corpus <- Corpus(DataframeSource(skills))
# Then to a document-term matrix with:
dtm <- DocumentTermMatrix(corpus)

# You can see the number of tokens in the data, referred to as terms and the number of characters in the longest token under maximal term length:
dtm

# You can also see a count of how many times each of the tokens are used in the 72 responses:
inspect(dtm)

# You will see that many of the tokens are uninteresting and uncommon and therefore can be removed from the analysis.
# This is easily achieved with the tm package using the following code:
dtm <- DocumentTermMatrix(corpus, control = list(removePunctuation = TRUE, stripWhitespace = TRUE, removeNumbers = TRUE, stopwords =  TRUE, tolower = TRUE, wordLengths=c(1,Inf)))

# You can see punctuation, unnecessary spaces, numbers and useless words such as “a” and “the” (called stopwords) are removed:
dtm
# The code also converts all tokens to lower case and makes sure tokens have at least 1 character (in many applications you may want to remove tokens with less than 3 characters but in this case tokens/words such as R with one character will be of interest)
Terms(dtm)

# You will see that many of the tokens are quite obscure words and are probably sparsely used in the data. The sparse terms can be removed using the following code: 
dtms <- removeSparseTerms(dtm, 0.98)
# The value of 0.98 was used here but you can experiment with different values to see how many words remain (between 0 and 1; closer to 0 = less words)

# You can see the remaining tokens with:
Terms(dtms)

# Now we can find the tokens that have a frequency of 5 or more:
findFreqTerms(dtms, 5) 

# find tokens/words associated with “data”: 
findAssocs(dtms, 'data', corlimit = 0.2) 
# Try different tokens/words and changing the corlimit (the lower limit of the correlation value between our word of interest and the rest of the words in our data).

# create a vector of associated tokens/words for all frequency used tokens/words:
findAssocs(dtms, findFreqTerms(dtms, 5), 0.25) 
