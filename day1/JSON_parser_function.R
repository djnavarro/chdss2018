
parseJSONlist <- function(json) {  
  require(RJSONIO)
  require(plyr)
  all <- as.data.frame(fromJSON(I(json[1])))
  #browser()
  
  for (i in 2:length(json)) {
    if (i %% 100 == 0) { print(i) }
    
    t = json[i]
    t2 = fromJSON(I(t))
    
    # if (is.null(t2$valueX)) {
    #  t2$valueX <- -1
    #  t2$valueY <- -1
      print(as.vector(t2))
    #}
    
    tmp <- as.data.frame(t2)
    
    all <- rbind.fill(tmp, all)
  }
  
  return (all)  
}