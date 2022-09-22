##################################################################
#' Claudinei Oliveira dos Santos
#' Biologo | Msc. Ecologia | Dr. Ciências Ambientais
#' claudineisan@pastoepixel.com
##################################################################

###
###
#' Pacotes, Funções e Configurações
options(scipen = 9999)

library(raster)

###
#' input
pastagem <- raster('data/pa_br_pasture_2018_1km.tif')
ppt_tc <- raster('data/pa_br_ppt_terraclimate_2020_12_4km.tif')
ppt_trmm <- brick('data/pa_br_trmm_3000_2015m12_lapig.tif')

###
#' process
stack(pastagem, ppt_tc, ppt_trmm)

ppt_tc_1km <- projectRaster(ppt_tc, 
                            pastagem,
                            method = 'ngb')

ppt_trmm_1km <- projectRaster(ppt_trmm, 
                              pastagem,
                              method = 'ngb')

img_all <- stack(pastagem, 
                 ppt_tc_1km, 
                 ppt_trmm_1km)

plot(img_all)

###
#' output
writeRaster(ppt_tc_1km, 
            file = 'cache/pa_br_ppt_terraclimate_2020_12_1km.tif',
            datatype = 'FLT4S',
            overwrite = TRUE)

writeRaster(ppt_trmm_1km, 
            file = 'cache/pa_br_trmm_3000_2015m12_1km.tif',
            datatype = 'FLT4S',
            overwrite = TRUE)

##################################################################
