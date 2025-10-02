##########
# Word Cloud RUME-NEEMSIS
# Sezptember 2025
# Arnaud NATAL
# arnaud.natal@ifpindia.org
##########


########## Initialisation
setwd("C:/Users/Arnaud/Documents/MEGA/ODRIIS materials/NEEMSIS papers/WCloud")


########## Install
# install.packages("tm")  # for text mining
# install.packages("SnowballC") # for text stemming
# install.packages("wordcloud2") # word-cloud generator 
# install.packages("RColorBrewer") # color palettes
# install.packages("htmlwidgets")
# install.packages("devtools")
# library(devtools)
# devtools::install_github("lchiffon/wordcloud2")


########## Load
library("tm")
library("SnowballC")
library("wordcloud2")
library("RColorBrewer")
library("htmlwidgets")


########## All
rm(list = ls())
# Import data
text<-readLines("all.txt", encoding = "utf-8")
doc<-Corpus(VectorSource(text))
# Data cleaning
doc<-tm_map(doc, content_transformer(tolower))
doc<-tm_map(doc, removePunctuation)
doc<-tm_map(doc, removeWords, stopwords("english"))
doc<-tm_map(doc, removeWords,c("among", "find", "study", "overcome", "key", "furthermore", "much", "control", "ordinary", "analyses", "last", "authors", "significantly", "including", "particularly", "conducted", "particularly", "observe", "show", "purpose", "far", "drawing", "also", "use", "based", "various"))
doc<-tm_map(doc, stripWhitespace)
# Text matrix
dtm<-TermDocumentMatrix(doc)
m<-as.matrix(dtm)
v<-sort(rowSums(m),decreasing=TRUE)
d<-data.frame(word = names(v),freq=v)
head(d, 10)
# Word cloud
pdf("all.pdf")
set.seed(1234)
wc1<-wordcloud2(data=d, size = 0.7, shape = 'circle', color='random-dark')
# Save
saveWidget(wc1,"all.html",selfcontained = F)
dev.off() 


########## Dissertations
rm(list = ls())
# Import data
text<-readLines("dissertations.txt", encoding = "utf-8")
doc<-Corpus(VectorSource(text))
# Data cleaning
doc<-tm_map(doc, content_transformer(tolower))
doc<-tm_map(doc, removePunctuation)
doc<-tm_map(doc, removeWords, stopwords("english"))
doc<-tm_map(doc, removeWords,c("among", "find", "study", "overcome", "key", "furthermore", "much", "control", "ordinary", "analyses", "last", "authors", "significantly", "including", "particularly", "conducted", "particularly", "observe", "show", "purpose", "far", "drawing", "also", "use", "based", "various", "chapter"))
doc<-tm_map(doc, stripWhitespace)
# Text matrix
dtm<-TermDocumentMatrix(doc)
m<-as.matrix(dtm)
v<-sort(rowSums(m),decreasing=TRUE)
d<-data.frame(word = names(v),freq=v)
head(d, 10)
# Word cloud
set.seed(1234)
wc1<-wordcloud2(data=d, size = 0.7, shape = 'circle', color='random-dark')
# Save
saveWidget(wc1,"dissertations.html",selfcontained = F)


########## RUME
rm(list = ls())
# Import data
text<-readLines("rume.txt", encoding = "utf-8")
doc<-Corpus(VectorSource(text))
# Data cleaning
doc<-tm_map(doc, content_transformer(tolower))
doc<-tm_map(doc, removePunctuation)
doc<-tm_map(doc, removeWords, stopwords("english"))
doc<-tm_map(doc, removeWords,c("among", "find", "study", "overcome", "key", "furthermore", "much", "control", "ordinary", "analyses", "last", "authors", "significantly", "including", "particularly", "conducted", "particularly", "observe", "show", "purpose", "far", "drawing", "also", "use", "based", "various"))
doc<-tm_map(doc, stripWhitespace)
# Text matrix
dtm<-TermDocumentMatrix(doc)
m<-as.matrix(dtm)
v<-sort(rowSums(m),decreasing=TRUE)
d<-data.frame(word = names(v),freq=v)
head(d, 10)
# Word cloud
set.seed(1234)
wc1<-wordcloud2(data=d, size = 0.7, shape = 'circle', color='random-dark')
# Save
saveWidget(wc1,"rume.html",selfcontained = F)


########## NEEMSIS
rm(list = ls())
# Import data
text<-readLines("neemsis.txt", encoding = "utf-8")
doc<-Corpus(VectorSource(text))
# Data cleaning
doc<-tm_map(doc, content_transformer(tolower))
doc<-tm_map(doc, removePunctuation)
doc<-tm_map(doc, removeWords, stopwords("english"))
doc<-tm_map(doc, removeWords,c("among", "find", "study", "overcome", "key", "furthermore", "much", "control", "ordinary", "analyses", "last", "authors", "significantly", "including", "particularly", "conducted", "particularly", "observe", "show", "purpose", "far", "drawing", "also", "use", "based", "various"))
doc<-tm_map(doc, stripWhitespace)
# Text matrix
dtm<-TermDocumentMatrix(doc)
m<-as.matrix(dtm)
v<-sort(rowSums(m),decreasing=TRUE)
d<-data.frame(word = names(v),freq=v)
head(d, 10)
# Word cloud
set.seed(1234)
wc1<-wordcloud2(data=d, size = 0.7, shape = 'circle', color='random-dark')
# Save
saveWidget(wc1,"neemsis.html",selfcontained = F)


########## NEEMSIS-1
rm(list = ls())
# Import data
text<-readLines("neemsis1.txt", encoding = "utf-8")
doc<-Corpus(VectorSource(text))
# Data cleaning
doc<-tm_map(doc, content_transformer(tolower))
doc<-tm_map(doc, removePunctuation)
doc<-tm_map(doc, removeWords, stopwords("english"))
doc<-tm_map(doc, removeWords,c("among", "find", "study", "overcome", "key", "furthermore", "much", "control", "ordinary", "analyses", "last", "authors", "significantly", "including", "particularly", "conducted", "particularly", "observe", "show", "purpose", "far", "drawing", "also", "use", "based", "various"))
doc<-tm_map(doc, stripWhitespace)
# Text matrix
dtm<-TermDocumentMatrix(doc)
m<-as.matrix(dtm)
v<-sort(rowSums(m),decreasing=TRUE)
d<-data.frame(word = names(v),freq=v)
head(d, 10)
# Word cloud
set.seed(1234)
wc1<-wordcloud2(data=d, size = 0.7, shape = 'circle', color='random-dark')
# Save
saveWidget(wc1,"neemsis1.html",selfcontained = F)


########## NEEMSIS-2
rm(list = ls())
# Import data
text<-readLines("neemsis2.txt", encoding = "utf-8")
doc<-Corpus(VectorSource(text))
# Data cleaning
doc<-tm_map(doc, content_transformer(tolower))
doc<-tm_map(doc, removePunctuation)
doc<-tm_map(doc, removeWords, stopwords("english"))
doc<-tm_map(doc, removeWords,c("among", "find", "study", "overcome", "key", "furthermore", "much", "control", "ordinary", "analyses", "last", "authors", "significantly", "including", "particularly", "conducted", "particularly", "observe", "show", "purpose", "far", "drawing", "also", "use", "based", "various"))
doc<-tm_map(doc, stripWhitespace)
# Text matrix
dtm<-TermDocumentMatrix(doc)
m<-as.matrix(dtm)
v<-sort(rowSums(m),decreasing=TRUE)
d<-data.frame(word = names(v),freq=v)
head(d, 10)
# Word cloud
set.seed(1234)
wc1<-wordcloud2(data=d, size = 0.7, shape = 'circle', color='random-dark')
# Save
saveWidget(wc1,"neemsis2.html",selfcontained = F)