#################################################
# TRATAMIENTO DE DATOS CMIP6 - WORLDCLIM       ##
# 9 GCM`S                                      ##
#################################################

library(rasterVis)
library(raster)
library(gridExtra)
library(rgdal)
library(ggspatial)
library(ggplot2)  

#Ruta de archivos
PATHPR<-"C:/TEMPORAL/BCC-CSM2-MR/PR"

#Asignaremos un índice a escala mensual
idx <- seq(as.Date('2008-01-15'), as.Date('2008-12-15'), 'month')

#Ahora podemos extraer información de un ráster en particular
GDALinfo("C:/TEMPORAL/BCC-CSM2-MR/SSP126/wc2.1_2.5m_bioc_BCC-CSM2-MR_ssp126_2021-2040.tif")  


#Podemos cargar a cada uno de los rásters de la siguiente forma:
r1<-raster("C:/TEMPORAL/BCC-CSM2-MR/SSP126/wc2.1_2.5m_prec_BCC-CSM2-MR_ssp126_2021-2040.tif")
r2<-raster("C:/TEMPORAL/BCC-CSM2-MR/SSP126/wc2.1_2.5m_tmax_BCC-CSM2-MR_ssp126_2021-2040.tif")
r3<-raster("C:/TEMPORAL/BCC-CSM2-MR/SSP126/wc2.1_2.5m_tmin_BCC-CSM2-MR_ssp126_2021-2040.tif")
r4<-raster("C:/TEMPORAL/BCC-CSM2-MR/SSP126/wc2.1_2.5m_bioc_BCC-CSM2-MR_ssp126_2021-2040.tif")

#Conoscamos algunas características: sist.de referencia, tamaños, etc
crs(r1)
ncell(r1)
nlayers(r1)

#Si el ráster requiere cambios en valores, veamos por ejemplo en el caso de °T en °Kelvin hacia °C
#rs2 <- calc(r2,fun=function(x){x-273.15})

#Grafiquemos un histograma de frecuencias
hist(r2,
     main="Distribution of maximum °T Values\nBCC-CSM2-MR model-SSP126 PERÍODO 2021-2040",
     xlab="°T value (°K)",
     ylab="Frequency",
     col="blue")

#Agreguemos algunos breaks a el histograma
DSMhist<-hist(r2,
              breaks=100,
              main="BCC-CSM2-MR model - Histogram of precipitation (mm) at global scale",
              col="wheat3",  # changes bin color
              xlab= "Elevation (m)")  # label the x-axis


#Veamos algunos gráficos simples
plot(r1,main="BCC-CSM2-MR model-SSP126 PERÍODO 2021-2040")
plot(r2,main="BCC-CSM2-MR model-SSP126 PERÍODO 2021-2040")


#Generamos una lista de todos los archivos rásters en una carpeta a tratar
SSP126_PR <- list.files(PATHPR,full.names = TRUE,pattern = ".tif$")
#Veamos la lista
SSP126_PR

# Creamos un raster stacK
SSP126_PR_stack <- stack(SSP126_PR)
#Agregar bands=1,2,3,.... si se desea tratar más bandas

#Veamos nuevamente el sistema de coordenadas y extensión del stack de rásters
crs(SSP126_PR_stack)
extent(SSP126_PR_stack)

#Generamos un gráfico simple con leyenda
plot(SSP126_PR_stack, main="BCC-CSM2-MR MODEL",ylab="latitude",xlab="longitude",
     legend.args = list(text = 'Precipitation (mm)', side = 3, font = 2.0, line = 0.5, cex =0.7,xleft=1))

#También podemos graficar un simple raster indicando una de las 12 bandas (meses) de interés
SSP126_PR_stack <- raster("C:/TEMPORAL/BCC-CSM2-MR/SSP126/wc2.1_2.5m_prec_BCC-CSM2-MR_ssp126_2021-2040.tif", 
         band = 2)

#Usaremos ahora una librería más dinámica: rasterviz
#Nos ayudaremos del índice mensual previamente configurado
SSP126_PR_stack <- setZ(SSP126_PR_stack, idx)
names(SSP126_PR_stack) <- month.abb

levelplot(SSP126_PR_stack,main="BCC-CSM2-MR MODEL-MONTHLY PRECIPITATION (mm)",
          margin =FALSE, xlab="longitude", ylab="latitude", col.regions=heat.colors(10))
