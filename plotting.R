(metadata <- read.csv("http://www.datacarpentry.org/R-genomics/data/Ecoli_metadata.csv"))
head(metadata)
genome_size <- metadata$genome_size 
plot(genome_size)
plot(genome_size, pch = 8)
?plot
hist(genome_size)
boxplot(genome_size ~ cit, metadata)
boxplot(genome_size ~ cit, metadata, col = c("pink", "purple", "darkgrey"), 
        main = "average expression difference between celltypes", ylab = "Expression")
library(ggplot2)
ggplot(metadata)
ggplot(metadata) + geom_point(aes(x = sample, y = genome_size))
