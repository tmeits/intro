
## Conjunto de datos de ejemplo
## - Leemos desde el archivo local

aranjuez <- read.csv('data/aranjuez.csv')

summary(aranjuez)

## Conjunto de datos de ejemplo
## - Añadimos algunas columnas

aranjuez$month <- as.numeric(
                  format(as.Date(aranjuez$X), '%m'))
aranjuez$year <- as.numeric(
                 format(as.Date(aranjuez$X), '%Y'))
aranjuez$day <- as.numeric(
                format(as.Date(aranjuez$X), '%j'))
aranjuez$jday <- julian(as.Date(aranjuez$X))
aranjuez$quarter <- quarters(as.Date(aranjuez$X))

## Lattice

## - Documentación: [[http://lmdvr.r-forge.r-project.org/figures/figures.html][Código y Figuras del libro]]

library(lattice)

## =xyplot=
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="xyplot.pdf")
xyplot(Radiation ~ TempAvg, data=aranjuez)
dev.off()

## =xyplot=
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="xyplotPG.pdf")
xyplot(Radiation ~ TempAvg, data=aranjuez,
       type=c('p', 'g'))
dev.off()

## =xyplot=
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="xyplotPRG.pdf")
xyplot(Radiation ~ TempAvg, data=aranjuez,
       type=c('p', 'r', 'g'),
       lwd=2, col.line='black')

dev.off()

## =xyplot=
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="xyplotSmooth.pdf")
xyplot(Radiation ~ TempAvg, data=aranjuez,
       type=c('p', 'smooth', 'g'),
       lwd=2, col.line='black')
dev.off()

## Paneles
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="xyplotYear.pdf")
xyplot(Radiation ~ TempAvg|factor(year),
       data=aranjuez)
dev.off()

## Grupos
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="xyplotQuarter.pdf")
xyplot(Radiation ~ TempAvg, groups=quarter,
       data=aranjuez, auto.key=list(space='right'))
dev.off()

## Paneles y grupos
## #+ATTR_LaTeX: width=0.6\textwidth

pdf(file="xyplotQuarterYear.pdf")
xyplot(Radiation ~ TempAvg|factor(year),
       groups=quarter,
       data=aranjuez,
       layout=c(4, 2),
       auto.key=list(space='right'))
dev.off()

## Paneles y grupos
## #+ATTR_LaTeX: width=0.6\textwidth

pdf(file="xyplotQuarterYearSmooth.pdf")
xyplot(Radiation ~ TempAvg|factor(year),
       groups=quarter,
       data=aranjuez,
       layout=c(4, 2),
       type=c('p', 'r'),
       auto.key=list(space='right'))
dev.off()

## Colores y tamaños
## #+ATTR_LaTeX: width=0.6\textwidth

pdf(file="xyplotColors.pdf")
xyplot(Radiation ~ TempAvg,
       type=c('p', 'r'),
       cex=2, col='blue',
       alpha=.5, pch=19,
       lwd=3, col.line='black',
       data=aranjuez)
dev.off()

## Colores con grupos
## #+ATTR_LaTeX: width=0.6\textwidth

pdf(file="xyplotColorGroups.pdf")
xyplot(Radiation ~ TempAvg,
       group=quarter,
       col=c('red', 'blue', 'green', 'yellow'),
       pch=19,
       auto.key=list(space='right'),
       data=aranjuez)
dev.off()

## Colores con grupos: =par.settings= y =simpleTheme=
## - Primero definimos el tema con =simpleTheme=

myTheme <- simpleTheme(col=c('red', 'blue',
                        'green', 'yellow'),
                        pch=19, alpha=.6)

## Colores con grupos: =par.settings= y =simpleTheme=
## - Aplicamos el resultado en =par.settings=
## #+ATTR_LaTeX: width=0.45\textwidth

pdf(file="myTheme.pdf")
xyplot(Radiation ~ TempAvg,
       groups=quarter,
       par.settings=myTheme,
       auto.key=list(space='right'),
       data=aranjuez)
dev.off()

## Colores: brewer.pal
## #+ATTR_LaTeX: width=0.45\textwidth

pdf(file="brewer.pdf")
library(RColorBrewer)
myTheme <- custom.theme(symbol=brewer.pal(n=4,
                        'Dark2'),
                        pch=19, alpha=.6)
xyplot(Radiation ~ TempAvg,
       groups=quarter,
       par.settings=myTheme,
       auto.key=list(space='right'),
       data=aranjuez)
dev.off()

## Paneles a medida
## #+ATTR_LaTeX: width=0.3\textwidth

pdf(file="panel.pdf")
xyplot(Radiation ~ TempAvg, data=aranjuez,
       panel=function(x, y, ...){
           panel.xyplot(x, y, ...)
           minIdx <- which.min(x)
           maxIdx <- which.max(x)
           panel.points(x[c(minIdx, maxIdx)],
                        y[c(minIdx, maxIdx)],
                        cex=2, col='red')
           panel.text(x[minIdx], y[minIdx],
                      'MIN', pos=1)
           })
dev.off()

## Matriz de gráficos de dispersión
## #+ATTR_LaTeX: width=0.45\textwidth

png(filename="splom.png")
splom(aranjuez[,c("TempAvg", "HumidAvg", "WindAvg",
                  "Rain", "Radiation", "ET")],
      pscale=0, alpha=0.6, cex=0.3, pch=19)
dev.off()

## Matriz de gráficos de dispersión
## #+ATTR_LaTeX: width=0.45\textwidth

png(filename="splomGroup.png")
splom(aranjuez[,c("TempAvg", "HumidAvg", "WindAvg",
                  "Rain", "Radiation", "ET")],
      groups=aranjuez$quarter,
      auto.key=list(space='right'),
      pscale=0, alpha=0.6, cex=0.3, pch=19)
dev.off()

## =levelplot=
## #+ATTR_LaTeX: width=0.6\textwidth

pdf(file="levelplot.pdf")
levelplot(TempAvg ~ year * day,
          data=aranjuez)
dev.off()

## =contourplot=
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="contourplot.pdf")
contourplot(Radiation ~ year * day,
            lwd=.5, labels=FALSE,
            region=TRUE, 
            data=aranjuez)
dev.off()

## Box-and-Whiskers
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="bwplot.pdf")
bwplot(Radiation ~ month, data=aranjuez,
       horizontal=FALSE, pch='|')
dev.off()

## Box-and-Whiskers
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="violin.pdf")
bwplot(Radiation ~ month, data=aranjuez,
       horizontal=FALSE,
       panel=panel.violin)
dev.off()

## Histogramas
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="histogram.pdf")
histogram(~Radiation|factor(year), data=aranjuez)
dev.off()

## Gráficos de densidad
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="density.pdf")
densityplot(~Radiation, groups=quarter,
            data=aranjuez,
            auto.key=list(space='right'))
dev.off()

## =dotplot=

avRad <- aggregate(Radiation ~ month * year,
                   data=aranjuez, FUN=mean)

## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="dotplot.pdf")
dotplot(month ~ Radiation|factor(year), data=avRad)
dev.off()

## Quantile-Quantile
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="qqHalf.pdf")
firstHalf <- aranjuez$quarter %in% c('Q1', 'Q2')

qq(firstHalf ~ Radiation, data=aranjuez)
dev.off()

## Quantile-quantile
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="qqWinter.pdf")
winter <- aranjuez$quarter %in% c('Q1', 'Q4')

qq(winter ~ Radiation, data=aranjuez)
dev.off()

## Quantile-Quantile
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="qqNorm.pdf")
qqmath(~TempAvg, data=aranjuez,
       groups=year, distribution=qnorm)
dev.off()

## Opciones de lattice
## Todas las figuras han sido generadas con unas opciones previamente
## definidas en =lattice.options=. Es necesario instalar el paquete
## =latticeExtra=.

library(latticeExtra)
myTheme=custom.theme.2(pch=19, cex=0.7,
                       region=rev(brewer.pal(9, 'YlOrRd')),
                       symbol = brewer.pal(n=8, name = "Dark2"))
myTheme$strip.background$col='transparent'
myTheme$strip.shingle$col='transparent'
myTheme$strip.border$col='transparent'
xscale.components.custom <- function(...){
    ans <- xscale.components.default(...)
    ans$top=FALSE
    ans}
yscale.components.custom <- function(...){
    ans <- yscale.components.default(...)
    ans$right=FALSE
    ans}
myArgs <- list(as.table=TRUE,
               between=list(x=0.5, y=0.2),
               xscale.components = xscale.components.custom,
               yscale.components = yscale.components.custom)
defaultArgs <- lattice.options()$default.args
lattice.options(default.theme = myTheme, default.args = modifyList(defaultArgs, myArgs))
