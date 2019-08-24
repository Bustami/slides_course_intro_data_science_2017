data <- read.csv(file='clasif_conmebol_9814.csv',  
                 header=T, stringsAsFactors=F, encoding='utf8')

paste0(getwd(), '/asflkajfk/kjgfkjasf')

names(data)
str(data)
dim(data)
head(data, 10)
tail(data)

data$Equipo

data[ 1, 1]
data[ 1, ]
data[ , 1]
data[ , 3]

data[ , 2:5]
data[ , c(2:4,7)]
data[ , 'Equipo']

data[ , -2]

names(data)[12] <- 'Rendimiento'
names(data)[11:13] <- c('Dif', 'Rendimiento', 'Clasifica')

data$Nueva <- data$GF / data$PJ

# 2
data2 <- read.table('movies.txt', header=T)

names(data2)
subset <- data2[which(data2$year>=2000 & data2$year<2003), ]
subset <- subset[order(subset$year, decreasing=F), ]


# 3
#install.packages('readxl')
library(readxl)
data3_h1 <- read_excel('datos_ruido_y_viento.xlsx', sheet=1, skip=1)
data3_h2 <- read_excel('datos_ruido_y_viento.xlsx', sheet=2, skip=1)

data3_h1$Proyecto[2:30] <- 'Riwe'
data3_h1[2:30, 'Proyecto'] <- 'Riwe'

data3_h2$Proyecto[2:30] <- data3_h1$Proyecto[2:30]

names(data3_h1)[7] <- 'Leq_RF_D'
summary(data3_h1$Leq_RF_D)
summary(data3_h1)
str(data3_h1)

table(data3_h1$fecha)

dim(data)[2]
ncol(data)

length(data$Equipo)

nchar(data$Equipo)

complete.cases(data3_h1$Proyecto)

table(complete.cases(data3_h1$Proyecto))

table(is.na(data3_h1$Proyecto))

table(data3_h1$Proyecto, useNA='ifany')

unique(data$Equipo)
unique(data3_h1$Proyecto)


data3_h1$hora_bien <- substr(data3_h1$hora, 12, 19)

data3_h1$Descripción <- gsub('Vivienda e', 'Vivienda de', data3_h1$Descripción)
'^(Vivienda|Edificación).*'

nchar('Vivienda de 1')
table(substr(data3_h1$Descripción, 1, 13))


data2$title[grep('.*time.*', data2$title)]
data2[grep('.* time.*', data2$title), 'title']
data2[grep('.* time .*|.* time', data2$title), 'title']

library(dplyr)
new_table <- subset(data, Pts > mean(Pts) & Pos.>=5, 
       select=c(Clasif, Equipo, Pts, Pos., Clasifica))

mean()
median()

a <- '1'
str(a)
b <- as.numeric(a)
str(b)

data3_h1$fecha <- as.Date(data3_h1$fecha, format='%Y-%m-%d')

weekdays(data3_h1$fecha)

Sys.timezone()
Sys.setlocale("LC_TIME", "English")

library(lubridate)
lubridate::year(data3_h1$fecha)

data4 <- read.csv('titanic-kaggle.csv')
c <- cut(data4$Age, 
         breaks = c(0, 10, 20, 30, 40, 50, 60, 70, 80, 90),
         labels = c('-11', '11-20','21-30', '31-40', '41-50', '51-60', '61-70', '71-80', '90+'),
         right = T)
data4$age_groups <- c

sum(table(data4$age_groups))



