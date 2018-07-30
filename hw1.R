data <- read.csv('ideology.csv', header = T, stringsAsFactors = F)
data = data[order(data$WNominate),]
dotchart(data$WNominate)

