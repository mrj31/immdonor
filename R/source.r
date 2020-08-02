library(flowWorkspace)
library(flowCore)
library(ImmPortR)
library(dplyr)
library(stringr)
library(openCyto)
library(MetaCyto)
library(ggcyto)
library(kableExtra)
library(plotly)
library(DBI)
source("R/donor_search.r")
source("R/panel_parser.R")

SDY702<- donor_search(study = "SDY702")
SDY1097<- donor_search(study = "SDY1097")
immport<- rbind(SDY702,SDY1097)
donormeta<- panel_parser(donorMeta = immport)
df<-donormeta

panels<- donormeta %>% group_by(panel_id, parameters) %>% count(marker_id)
panelid<- unique(panels$panel_id)

fcs<- df %>%
  dplyr::filter(panel_id == "FCM-12")

controlfcs<- df %>%
  dplyr::filter(panel_id == "FCM-1"|panel_id == "FCM-4"|panel_id == "FCM-8"|panel_id == "FCM-20"|panel_id == "FCM-23"|panel_id == "FCM-24")

fcs<- df %>%
  dplyr::filter(panel_id == "FCM-2"|panel_id == "FCM-3"|panel_id == "FCM-5"|panel_id == "FCM-6"|panel_id == "FCM-7"|panel_id == "FCM-29")

ki67 <- df %>%
  dplyr::filter(panel_id == "FCM-9"|panel_id == "FCM-10"|panel_id == "FCM-11")

tcr <- df %>%
  dplyr::filter(panel_id == "FCM-13"|panel_id == "FCM-14"|panel_id == "FCM-15"||panel_id == "FCM-16"|panel_id == "FCM-17")

treg<- df %>%
  dplyr::filter(panel_id == "FCM-18"|panel_id == "FCM-19"|panel_id == "FCM-21"|panel_id == "FCM-22"|panel_id == "FCM-25"|panel_id == "FCM-26")



fcs<- df %>%
  dplyr::filter(panel_id == "FCM-2"|panel_id == "FCM-3")

fcs_files<- fcs$fcs_files
cs<- load_cytoset_from_fcs(files = fcs_files)

# link metadata
p<- pData(cs)
m<- cbind(p,fcs)
pData(cs)<- m

# link markers
channels <- colnames(cs)
markers <- as.vector(pData(parameters(cs[[1]]))$desc)
names(markers)<- channels
markernames(cs) <- markers

# Compensate
comps <- lapply(cs, function(cf) spillover(cf)$SPILL)
cs_comp <- compensate(cs, comps)

# FCStransTransform
channels_to_exclude <- c(grep(colnames(cs), pattern="FSC"),
                         grep(colnames(cs), pattern="SSC"),
                         grep(colnames(cs), pattern="Time"))
chnls <- colnames(cs)[-channels_to_exclude]

transListtransform <- transformList(chnls, FCSTransTransform(transformationId = "defaultFCSTransTransform", channelrange = 2^18, channeldecade = 4.5, range = 4096, cutoff = -111, w = 0.5, rescale = TRUE)
)

fcstrans<- FCSTransTransform(transformationId = "defaultFCSTransTransform", channelrange = 2^18, channeldecade = 4.5, range = 4096, cutoff = -111, w = 0.5, rescale = TRUE)
transList <- transformList(chnls, fcstrans)

cs_trans<- transform(cs_comp,transList)
save_cytoset(cs_trans, path = "R/cytosets/fcm21")

gs<- GatingSet(cs_trans)

gs_add_gating_method(gs, alias = "nonDebris",
                     pop = "+",
                     parent = "root",
                     dims = "FSC-A",
                     gating_method = "mindensity",
                     gating_args = "min = 20000, max=50000",
                     collapseDataForGating = "TRUE",
                     groupBy = "biosampleType") 

gs_add_gating_method(gs, alias = "singlets",
                     pop = "+",
                     parent = "nonDebris",
                     dims = "FSC-A,FSC-H",
                     gating_method = "singletGate")

gs_add_gating_method(gs,
                     pop = "+/-+/-",
                     parent = "singlets",
                     dims = "CD3,CD4",
                     gating_method = "mindensity",
                     gating_args = "min= 1250, max=2500",
                     collapseDataForGating = "TRUE",
                     groupBy = "biosampleType")

save_gs(gs, path = "R/gatingsets/fcm21")
