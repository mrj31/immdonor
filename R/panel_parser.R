### ORGINAL CODE BY ZICHENG HU https://github.com/hzc363 IN THE METACYTO REPO https://github.com/hzc363/MetaCyto
### CREDIT TO JU YEONG KIM https://github.com/juyeongkim
### MODIFIED BY MOHAMMAD JAFFERY 

panel_parser <- function (donorMeta= meta) {cat("Parsing Donor List ")
  filepath = donorMeta$filePath
  headers <- lapply(filepath, function(file) read.FCSheader(file))
  markers <- sapply(headers, function(x) {
    header <- x[[1]]
    par <- as.integer(header["$PAR"])
    PNN <- unname(header[paste0("$P", seq_len(par), "N")])
    PNS <- unname(header[paste0("$P", seq_len(par), "S")])
    markers = paste(PNN,PNS,sep = "-")
    return(paste(markers, collapse = "|"))
  })

  panel = sapply(markers, function(x) {
    if (x == "DoesNotExist") {
      return("DoesNotExist")
    }
    w = which(unique(markers) == x)
    w = paste0("FCM-",w)
    return(w)
  })

  parameters<- sapply(headers, function(x) {
    header <- x[[1]]
    par <- as.integer(header["$PAR"])
  })

  marker2 <- sapply(headers, function(x) {
    header <- x[[1]]
    par <- as.integer(header["$PAR"])
    PNN <- unname(header[paste0("$P", seq_len(par), "N")])
    PNS <- unname(header[paste0("$P", seq_len(par), "S")])
    markers = paste(PNN,PNS,sep = "-")
    channels_to_exclude <- c(grep(markers, pattern="FSC"),
                             grep(markers, pattern="SSC"),
                             grep(markers, pattern="Time"))
    return(paste(markers[-channels_to_exclude], collapse = "|"))
  })

  names(panel) = NULL

  inputMeta = data.frame(panel_id = panel, marker_id = markers, markers=marker2, parameters = parameters)
  inputMeta = cbind(donorMeta,inputMeta)
  inputMeta = subset(inputMeta, !grepl("DoesNotExist", inputMeta$panel_id))
  inputMeta$panel_id <- as.character(inputMeta$panel_id)
  inputMeta = unique(inputMeta)
  return(inputMeta)
}

