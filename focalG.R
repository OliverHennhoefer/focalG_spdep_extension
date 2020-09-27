focalG <- function(x, listw, listw_f, zero.policy=NULL, spChk=NULL, GeoDa=FALSE) {
  require(spdep)
  
  if (!inherits(listw, "listw"))
    stop(paste(deparse(substitute(listw)), "is not a listw object"))
  if (!is.numeric(x))
    stop(paste(deparse(substitute(x)), "is not a numeric vector"))
  if (is.null(zero.policy))
    zero.policy <- get("zeroPolicy", envir = .spdepOptions)
  stopifnot(is.logical(zero.policy))
  stopifnot(is.vector(x))
  if (any(is.na(x))) stop(paste("NA in ", deparse(substitute(x))))
  n <- length(listw$neighbours)                               ##
  if (n != length(x))stop("Different numbers of observations")
  if (is.null(spChk)) spChk <- get.spChkOption()
  if (spChk && !chkIDs(x, listw))
    stop("Check of data and weights ID integrity failed")
  
  #Spatially Lagged Direct Neibhors
  lx <- lag.listw(listw, x, zero.policy=zero.policy)
  #Spatially Lagged Focal Area
  lf_f <- lag.listw(listw_f, x, zero.policy=zero.policy)
  
  #Variance Calculation for every Neighborhood
  list <- weighted_focal_neighbors$neighbours[1:length(weighted_focal_neighbors$neighbours)]
  n.obs <- sapply(list, length)
  seq.max <- seq_len(max(n.obs))
  neighbors_df_id <- t(sapply(list, "[", i = seq.max))
  #neighbors_df_id[is.na(neighbors_df_id)] <- 0
  ras <- data.frame(id=seq.int(length(x)), val=x )
  neighbors_df_id[neighbors_df_id %in% ras$id] <- ras$val[match(neighbors_df_id, ras$id, nomatch=0)]
  #neighbors_df_id[neighbors_df_id==0] <- NA
  foc.var <- apply(neighbors_df_id,1, var, na.rm = T) #si2
  
  #Focal Getis-Ord
  Wi <- sapply(listw$weights, sum) #1 for row-standardized weights                              
  S1i <- sapply(listw$weights, function(x) sum(x^2))            
  EG <- Wi*lf_f 
  res <- (lx - EG)                                           
  
  VG <- foc.var*(((n-1)*S1i - Wi^2)/(n-2))
  res <- res / sqrt(VG)                                         
  
  attr(res, "call") <- match.call()
  class(res) <- "localG"
  
  res
}
