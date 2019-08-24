#### Ejemplos

### dataset 1
data <- read.csv(file='clasif_conmebol_9814.csv', header=T, stringsAsFactors=F, encoding='utf8')

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


## Ejemplo 1
names(data)
names(data)[2] <- 'Posicion'
names(data)[12:13] <- c('Rendimiento', 'Clasifica')


## Ejemplo 2
data$new <- data$Pts / data$PJ




### dataset 2
data2 <- read.table('movies.txt', header=T)


## Ejemplo 3
names(data2)
subset <- data2[which(data2$year>=2000 & data2$year<2003), ]


## Ejemplo 4
subset <- subset[order(subset$year, decreasing=F), ]



### dataset 3
#install.packages('readxl')
library(readxl)
data3_h1 <- read_excel('datos_ruido_y_viento.xlsx', sheet=1, skip=1)
data3_h2 <- read_excel('datos_ruido_y_viento.xlsx', sheet=2, skip=1)


## Ejemplo 5
data3_h1$Proyecto
data3_h1$Proyecto[1:30] <- 'Riwe'
#data3_h1[1:30, 'Proyecto'] <- 'Riwe'  # otra opción
data3_h1$Proyecto[31:41] <- 'La Cabaña'
data3_h1$Proyecto[42:52] <- 'Mulchén'
data3_h1$Proyecto[53:68] <- 'Los Buenos Aires'

data3_h2$Proyecto #  tiene otra estructura (son menos mediciones)


## Ejemplo 6
names(data3_h1)[7] <- 'Leq_RF_D'
summary(data3_h1$Leq_RF_D)
summary(data3_h1)

str(data3_h1)
table(data3_h1$fecha, useNA='ifany')


## Ejemplo 7
complete.cases(data3_h1$Proyecto)
table(complete.cases(data3_h1$Proyecto), useNA='ifany')

table(is.na(data3_h1$Proyecto))
table(data3_h1$Proyecto, useNA='ifany')


## Ejemplo 8
unique(data$Equipo)
unique(data3_h1$Proyecto)


## Ejemplo 9
data3_h1$Descripción <- gsub('Vivienda e', 'Vivienda de', data3_h1$Descripción)
nchar('Vivienda de 1')
table(substr(data3_h1$Descripción, 1, 13), useNA='ifany')

data3_h1$Num_pisos <- substr(data3_h1$Descripción, 13, 13)

# otra opción
data3_h1$Num_pisos_B <- gsub('.*Vivienda de ', '', data3_h1$Descripción)
data3_h1$Num_pisos_B <- gsub(' piso.*', '', data3_h1$Num_pisos_B)


## Ejemplo 10
data2[grep('.*time.*', data2$title), 'title']           # sin espacios
data2[grep('.* time .*', data2$title), 'title']         # con espacios
data2[grep('.* time .*|.* time', data2$title), 'title'] # con espacios o solo con espacio antes


## Ejemplo 11
library(dplyr)
names(data2)
new <- filter(data2[, -c(7:16)], (year >= 1990) & ( rating > median(rating) ))
new <- arrange(new, desc(year), desc(rating))


## Ejemplo 12
str(data2)
data2$fecha <- as.Date(paste0(data2$year, '-01-01'), format='%Y-%m-%d')


## Ejemplo 13
data3_h1$weekday <- weekdays(data3_h1$fecha)
data3_h1$weekday # Lo tengo en inglés # Sys.getlocale("LC_TIME")
data3_h1$weekend <- ifelse(data3_h1$weekday=='Saturday' | data3_h1$weekday=='Sunday', TRUE, FALSE)
table(data3_h1$weekend, useNA='ifany')

data3_h2$weekday <- weekdays(data3_h2$fecha)
data3_h2$weekend <- ifelse(data3_h2$weekday=='Saturday' | data3_h2$weekday=='Sunday', TRUE, FALSE)
table(data3_h2$weekend, useNA='ifany')



## Ejemplo 14
ncol(data3_h1)
ncol(data3_h2)
names(data3_h1) # data3_h1 quedó con las columnas adicionales de número de pisos
names(data3_h2) # la columna 7 no es igual ya que tiene una N
# un criterio es crear una nueva columna en cada data frame que se llame periodo y
# llenarla con "Diurno" y "Nocturno" según corresponda y renombrar las columnas 7 "Leq_RF"
data3_h1$Periodo <- 'Diurno'
data3_h2$Periodo <- 'Nocturno'
names(data3_h1)[7] <- names(data3_h2)[7] <- 'Leq_RF'

data3 <- rbind(data3_h1[, -c(11:12)], data3_h2)
 


### dataset4
data4 <- read.csv('titanic-kaggle.csv')

## Ejemplo 15
str(data4$Age)
a <- cut(data4$Age, 
          breaks = c(0, 10, 20, 30, 40, 50, 60, 70, 80, 90),
          labels = c('-10', '11-20','21-30', '31-40', '41-50', '51-60', '61-70', '71-80', '90+'),
          right = T)
data4$age_groups <- a
table(data4$age_groups, useNA='ifany')
 

## Ejemplo 16
library(rvest)
pos <- data.frame(matrix(vector(), 0, 10,
                         dimnames=list(c(), c('Club', 'PJ', 'PG', 'PE', 'PP', 'GF', 'GC', 'Dif', 'PTS', 'Year'))),
                  stringsAsFactors=F)
 
 for (year in seq(2011, 2017))
 {
         if (year<=2015) {auxyear= year - 1} else {auxyear <- year}
         
         urlpos <- paste0('http://www.espn.cl/futbol/posiciones/_/liga/conmebol.libertadores/season/', auxyear)
         
         html <- html(urlpos)
         htmlt <- as.data.frame(html_table(html, fill=T))
         htmlt$Year <- year
         names(htmlt) <- names(pos)
         pos <- rbind(pos, htmlt)
 }
 
# como pueden darse cuenta, luego hay que limpiar la columna con los nombres de equipos :D

