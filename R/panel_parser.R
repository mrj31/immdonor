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


  names(panel) = NULL

  inputMeta = data.frame(panel_id = panel, marker_id = markers, parameters = parameters)
  inputMeta = cbind(donorMeta,inputMeta)
  inputMeta = subset(inputMeta, !grepl("DoesNotExist", inputMeta$panel_id))
  inputMeta$panel_id <- as.character(inputMeta$panel_id)
  inputMeta = unique(inputMeta)
  return(inputMeta)
}

