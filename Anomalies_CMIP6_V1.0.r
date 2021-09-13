################################################################################
#DETERMINATION OF PERCENTAGE ANOMALIES                                         #
#IN CMIP6 CLIMATE MODEL DATASETS                                               #
################################################################################

#Author: Julio Montenegro Gambini, P.E. ASCE, M.Sc.,
#PhD fellow - Technische Universiteit Delft (TU Delft), Netherlands.

#Current version: 1.0

#The data used here are CMIP6 downscaled future climate projections. 
#The downscaling and calibration (bias correction) was done with WorldClim 
#v2.1 as baseline climate.
#More info: https://www.worldclim.org/data/cmip6/cmip6climate.html

#REQUIRED PACKAGES AND INDICATIONS!=============================================
library(raster)
#Important note: The baseline climatology files must be in one sub-folder 
#inside the main folder, also other folder containing climate model files

#SETTING MAIN WORKING DIRECTORY=================================================
wdir="D:/RESEARCH/CMIP6 ASESSMENT PERU/R PROGRAMMING"
setwd(wdir)

#SETTING VARIABLE, CLIMATE MODEL AND TIME BLOCK NAMES===========================
patvariab="prec_"
modelname="_BCC-CSM2-MR"
ssp="ssp126"
block_1="2021-2040"
block_2="2041-2060"
block_3="2061-2080"
block_4="2081-2100"

#OPERATIONS USING MULTIBAND RASTER DATASET ==================================
#Select a single file to stack
setwd(wdir)
data<-stack("_BCC-CSM2-MR/_BCC-CSM2-MR_ssp126_2021-2040.tif")

#Getting layer names
indices <- names(data)

#a) Summing layers of the raster file
datasum <- calc(data, sum)
writeRaster(datasum,'sumlayers.tif',options=c('TFW=YES'))

#b) Mean using the layers of the raster file
datamean <- calc(data, mean)
writeRaster(datamean,'mean.tif',options=c('TFW=YES'))

#c) Function applied to all the layers of the raster file
datafun <- calc(data, fun=function(x){x * 2})
writeRaster(datafun,'fun.tif',options=c('TFW=YES'))

#IMPORTING THE BASELINE CLIMATOLOGY DATASET=====================================
setwd(wdir)
setwd("Baseline_Climatology_Worldclim/")
hist_files=list.files(pattern=patvariab)
data_hist<-stack(hist_files)

#IMPORTING THE CLIMATE MODEL DATASET ===========================================
setwd(wdir)
setwd(modelname)
model_files=list.files(pattern=modelname)
data_model<-stack(model_files)

#CREATING DIRECTORIES  =========================================================
setwd(wdir)
setwd(modelname)
dir.create(block_1)
dir.create(block_2)
dir.create(block_3)
dir.create(block_4)

#ONLY: In case of need GeoTIFF files (months) (saved as .tif files)
s <- unstack(data_model)
namesVector<- c("January", "February","March","April","May","June","July",
                "August","September","October","November","December")
for(i in seq_along(s)){writeRaster(s[[i]], filename=namesVector[i], format="GTiff")}

#OBTAINING ANOMALIES============================================================
setwd(wdir)
setwd(modelname)
#IMPORTANT: Forget message "Raster objects have different extents. Result for their intersection is returned"
#SSP126 2021-2040
Jan<-((data_model@layers[[1]]-data_hist@layers[[1]])/data_hist@layers[[1]])*100
Feb<-((data_model@layers[[2]]-data_hist@layers[[2]])/data_hist@layers[[2]])*100
Mar<-((data_model@layers[[3]]-data_hist@layers[[3]])/data_hist@layers[[3]])*100
Apr<-((data_model@layers[[4]]-data_hist@layers[[4]])/data_hist@layers[[4]])*100
May<-((data_model@layers[[5]]-data_hist@layers[[5]])/data_hist@layers[[5]])*100
Jun<-((data_model@layers[[6]]-data_hist@layers[[6]])/data_hist@layers[[6]])*100
Jul<-((data_model@layers[[7]]-data_hist@layers[[7]])/data_hist@layers[[7]])*100
Ago<-((data_model@layers[[8]]-data_hist@layers[[8]])/data_hist@layers[[8]])*100
Sep<-((data_model@layers[[9]]-data_hist@layers[[9]])/data_hist@layers[[9]])*100
Oct<-((data_model@layers[[10]]-data_hist@layers[[10]])/data_hist@layers[[10]])*100
Nov<-((data_model@layers[[11]]-data_hist@layers[[11]])/data_hist@layers[[11]])*100
Dec<-((data_model@layers[[12]]-data_hist@layers[[12]])/data_hist@layers[[12]])*100

writeRaster(Jan,file.path(block_1, paste(modelname,"_anom_Jan_",block_1,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Feb,file.path(block_1, paste(modelname,"_anom_Feb_",block_1,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Mar,file.path(block_1, paste(modelname,"_anom_Mar_",block_1,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Apr,file.path(block_1, paste(modelname,"_anom_Apr_",block_1,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(May,file.path(block_1, paste(modelname,"_anom_May_",block_1,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Jun,file.path(block_1, paste(modelname,"_anom_Jun_",block_1,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Jul,file.path(block_1, paste(modelname,"_anom_Jul_",block_1,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Ago,file.path(block_1, paste(modelname,"_anom_Ago_",block_1,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Sep,file.path(block_1, paste(modelname,"_anom_Sep_",block_1,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Oct,file.path(block_1, paste(modelname,"_anom_Oct_",block_1,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Nov,file.path(block_1, paste(modelname,"_anom_Nov_",block_1,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Dec,file.path(block_1, paste(modelname,"_anom_Dec_",block_1,"_",ssp,".tif",sep="")),options=c('TFW=YES'))

#2041-2060
Jan<-((data_model@layers[[13]]-data_hist@layers[[1]])/data_hist@layers[[1]])*100
Feb<-((data_model@layers[[14]]-data_hist@layers[[2]])/data_hist@layers[[2]])*100
Mar<-((data_model@layers[[15]]-data_hist@layers[[3]])/data_hist@layers[[3]])*100
Apr<-((data_model@layers[[16]]-data_hist@layers[[4]])/data_hist@layers[[4]])*100
May<-((data_model@layers[[17]]-data_hist@layers[[5]])/data_hist@layers[[5]])*100
Jun<-((data_model@layers[[18]]-data_hist@layers[[6]])/data_hist@layers[[6]])*100
Jul<-((data_model@layers[[19]]-data_hist@layers[[7]])/data_hist@layers[[7]])*100
Ago<-((data_model@layers[[20]]-data_hist@layers[[8]])/data_hist@layers[[8]])*100
Sep<-((data_model@layers[[21]]-data_hist@layers[[9]])/data_hist@layers[[9]])*100
Oct<-((data_model@layers[[22]]-data_hist@layers[[10]])/data_hist@layers[[10]])*100
Nov<-((data_model@layers[[23]]-data_hist@layers[[11]])/data_hist@layers[[11]])*100
Dic<-((data_model@layers[[24]]-data_hist@layers[[12]])/data_hist@layers[[12]])*100

writeRaster(Jan,file.path(block_2, paste(modelname,"_anom_Jan_",block_2,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Feb,file.path(block_2, paste(modelname,"_anom_Feb_",block_2,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Mar,file.path(block_2, paste(modelname,"_anom_Mar_",block_2,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Apr,file.path(block_2, paste(modelname,"_anom_Apr_",block_2,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(May,file.path(block_2, paste(modelname,"_anom_May_",block_2,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Jun,file.path(block_2, paste(modelname,"_anom_Jun_",block_2,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Jul,file.path(block_2, paste(modelname,"_anom_Jul_",block_2,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Ago,file.path(block_2, paste(modelname,"_anom_Ago_",block_2,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Sep,file.path(block_2, paste(modelname,"_anom_Sep_",block_2,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Oct,file.path(block_2, paste(modelname,"_anom_Oct_",block_2,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Nov,file.path(block_2, paste(modelname,"_anom_Nov_",block_2,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Dec,file.path(block_2, paste(modelname,"_anom_Dec_",block_2,"_",ssp,".tif",sep="")),options=c('TFW=YES'))

#2061-2080
Jan<-((data_model@layers[[25]]-data_hist@layers[[1]])/data_hist@layers[[1]])*100
Feb<-((data_model@layers[[26]]-data_hist@layers[[2]])/data_hist@layers[[2]])*100
Mar<-((data_model@layers[[27]]-data_hist@layers[[3]])/data_hist@layers[[3]])*100
Apr<-((data_model@layers[[28]]-data_hist@layers[[4]])/data_hist@layers[[4]])*100
May<-((data_model@layers[[29]]-data_hist@layers[[5]])/data_hist@layers[[5]])*100
Jun<-((data_model@layers[[30]]-data_hist@layers[[6]])/data_hist@layers[[6]])*100
Jul<-((data_model@layers[[31]]-data_hist@layers[[7]])/data_hist@layers[[7]])*100
Ago<-((data_model@layers[[32]]-data_hist@layers[[8]])/data_hist@layers[[8]])*100
Sep<-((data_model@layers[[33]]-data_hist@layers[[9]])/data_hist@layers[[9]])*100
Oct<-((data_model@layers[[34]]-data_hist@layers[[10]])/data_hist@layers[[10]])*100
Nov<-((data_model@layers[[35]]-data_hist@layers[[11]])/data_hist@layers[[11]])*100
Dic<-((data_model@layers[[36]]-data_hist@layers[[12]])/data_hist@layers[[12]])*100

writeRaster(Jan,file.path(block_3, paste(modelname,"_anom_Jan_",block_3,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Feb,file.path(block_3, paste(modelname,"_anom_Feb_",block_3,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Mar,file.path(block_3, paste(modelname,"_anom_Mar_",block_3,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Apr,file.path(block_3, paste(modelname,"_anom_Apr_",block_3,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(May,file.path(block_3, paste(modelname,"_anom_May_",block_3,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Jun,file.path(block_3, paste(modelname,"_anom_Jun_",block_3,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Jul,file.path(block_3, paste(modelname,"_anom_Jul_",block_3,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Ago,file.path(block_3, paste(modelname,"_anom_Ago_",block_3,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Sep,file.path(block_3, paste(modelname,"_anom_Sep_",block_3,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Oct,file.path(block_3, paste(modelname,"_anom_Oct_",block_3,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Nov,file.path(block_3, paste(modelname,"_anom_Nov_",block_3,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Dec,file.path(block_3, paste(modelname,"_anom_Dec_",block_3,"_",ssp,".tif",sep="")),options=c('TFW=YES'))

#2081-2100
Jan<-((data_model@layers[[37]]-data_hist@layers[[1]])/data_hist@layers[[1]])*100
Feb<-((data_model@layers[[38]]-data_hist@layers[[2]])/data_hist@layers[[2]])*100
Mar<-((data_model@layers[[39]]-data_hist@layers[[3]])/data_hist@layers[[3]])*100
Apr<-((data_model@layers[[40]]-data_hist@layers[[4]])/data_hist@layers[[4]])*100
May<-((data_model@layers[[41]]-data_hist@layers[[5]])/data_hist@layers[[5]])*100
Jun<-((data_model@layers[[42]]-data_hist@layers[[6]])/data_hist@layers[[6]])*100
Jul<-((data_model@layers[[43]]-data_hist@layers[[7]])/data_hist@layers[[7]])*100
Ago<-((data_model@layers[[44]]-data_hist@layers[[8]])/data_hist@layers[[8]])*100
Sep<-((data_model@layers[[45]]-data_hist@layers[[9]])/data_hist@layers[[9]])*100
Oct<-((data_model@layers[[46]]-data_hist@layers[[10]])/data_hist@layers[[10]])*100
Nov<-((data_model@layers[[47]]-data_hist@layers[[11]])/data_hist@layers[[11]])*100
Dic<-((data_model@layers[[48]]-data_hist@layers[[12]])/data_hist@layers[[12]])*100

writeRaster(Jan,file.path(block_4, paste(modelname,"_anom_Jan_",block_4,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Feb,file.path(block_4, paste(modelname,"_anom_Feb_",block_4,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Mar,file.path(block_4, paste(modelname,"_anom_Mar_",block_4,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Apr,file.path(block_4, paste(modelname,"_anom_Apr_",block_4,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(May,file.path(block_4, paste(modelname,"_anom_May_",block_4,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Jun,file.path(block_4, paste(modelname,"_anom_Jun_",block_4,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Jul,file.path(block_4, paste(modelname,"_anom_Jul_",block_4,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Ago,file.path(block_4, paste(modelname,"_anom_Ago_",block_4,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Sep,file.path(block_4, paste(modelname,"_anom_Sep_",block_4,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Oct,file.path(block_4, paste(modelname,"_anom_Oct_",block_4,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Nov,file.path(block_4, paste(modelname,"_anom_Nov_",block_4,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
writeRaster(Dec,file.path(block_4, paste(modelname,"_anom_Dec_",block_4,"_",ssp,".tif",sep="")),options=c('TFW=YES'))
