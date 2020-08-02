donor_search<-function(study){
  files <- query_filePath(study)
  files <- files[files$fileDetail == "Flow cytometry result", ]
  files <- files[grepl(".fcs$", files$fileName), ]
  files$filePath <- file.path(study, "ResultFiles", "Flow_cytometry_result",files$fileName)
  files$isPath<- file.path(study,"@files","rawdata","flow_cytometry")
  files$fcs_files<- file.path(study, "ResultFiles", "Flow_cytometry_result",files$fileName)
  data <- file.path("data",files$fileName)
  files$dataPath <- paste0(data,".fcs")
  std <- files
  return(std)
}
