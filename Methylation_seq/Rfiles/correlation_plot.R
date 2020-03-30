###load packages
library(ggplot2)
library(dplyr)
library(RColorBrewer)
library(tidyr)
#install.packages("corrplot")
library(corrplot)

###load data
cor <- read.delim(file = "LOCATION")
head(cor)
sample_name <- colnames(cor) 
row.names(cor) <- sample_name
cor <- as.matrix(cor)

###plot data
cor_heatmap <- corrplot(cor, type="upper", 
                        tl.col="black",
                        tl.cex=1,
                        cl.cex =1, 
                        cl.offset = .5, 
                        #addCoef.col = "white",
                        #rect.col = "black", rect.lwd = 1,
                        #tl.pos ="lt",
                        #cl.pos ="lower",
                        cl.lim=c(0,1),
                        cl.align.text="l",
                        col=brewer.pal(n=15, name="RdBu"))

cor_heatmap
