install.packages('ggplot2movies')
install.packages('ggplot2')

library("ggplot2")
library("faithful")

#Saving dataset into dataframe
mydata <- `breast.cancer(2)`

#Initial analysis
dim(mydata) #Dimension of dataframe
head(mydata) #First few rows of dataframe
str(mydata) #Structure of dataframe

#Checking distributions of each column
ggplot(data = mydata) + geom_bar(aes(x = V1)) #Bar graph for V1 (cancer recurrence)
ggplot(data = mydata) + geom_bar(aes(x = V5)) #Bar graph for V5 (number of lymph nodes w/ cancer)
ggplot(data = mydata) + geom_bar(aes(x = V8)) #Bar graph for V8 (left or right breast)
ggplot(data = mydata) + geom_bar(aes(x = V9)) #Bar graph for V9 (location on breast)
ggplot(data = mydata) + geom_bar(aes(x = V10)) #Bar graph for V10 (radiation treatment - yes/no)

#Checking number of '?' in each column
colSums(mydata == '?')

#Create new dataframe removing all rows from dataset where V12 has '?' in the same row
mydata1 <- mydata[!mydata[,9] == '?',]
dim(mydata1) #check dimension of new dataset
colSums(mydata1 == '?') #Check sum of '?' in each column

#Generate advanced scatterplot
myplot <- ggplot(data = mydata1, aes(x = V8, y = V5)) #x=V8, y=V5
myplot <- myplot + facet_wrap(~V9, ncol = 5) #creating multiple columns using V9 categories
myplot <- myplot + geom_jitter(aes(colour = V1, size = V10), alpha = 0.5) #adding jitter for ease of reading - V1=colour differentiator, V10=Size differentiator
myplot <- myplot + scale_color_manual(values=c("green", "red"))
myplot <- myplot + guides(color = guide_legend(title = "Recurrence")) + guides(size = guide_legend(title = "Radiation Treatment")) #Changing legend titles
myplot <- myplot + labs(title = "Relation of Breast Cancer to Region and Number of Tumors", x = "Breast (Left or Right)", y = "Number of Lymph Nodes indicating Cancer") #adding title and changing axis labels
myplot <- myplot + theme_classic() #Change Theme to white background and no gridline
myplot <- myplot + annotate(geom = "rect", xmin = 0, xmax = 2.6, ymin = 0.5, ymax = 1.5, alpha = 0.2) #add rect to show LowTumor
add_text = data.frame(V8 = 'left', V5 = '6-8', V9 = 'left_low', label = "Left-Low Risk") #dataframe for faceted text
myplot <- myplot + geom_text(data = add_text,label=add_text$label, size = 3) #Creating text in Left Breast, 6-8 tumors, left_low region
add_text1 = data.frame(V8 = 'left', V5 = '0-2', V9 = 'central', label = "LowTumor Benefit") #dataframe for faceted text
myplot <- myplot + geom_text(data = add_text1,label=add_text1$label, size = 3) #Creating text in Left Breast, 0-2 tumors, central region
add_rect = data.frame(V8 = 'left', V5 = '3-5', V9 = 'left_low') #dataframe for faceted rectangle
myplot + geom_rect(data = add_rect, aes(xmin = 0, xmax = 2, ymin = 4.5, ymax = 6.5), fill = 'blue', alpha = 0.1, colour = 'blue') #Rectangle to highlight left-low region risk
