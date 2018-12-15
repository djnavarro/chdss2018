
# Define the Bayesian goodness of fit test for a binary variable. Taken
# from Appendix A of the Wagenmakers (2007) paper, but it wasn't original
# there. It's a standard model that has been around for decades at least.
BayesianGOFTest <- function( counts, null=.5, prior=c(1,1) ){
  
  nullLikelihood <- dbinom( x=counts[1], size=sum(counts), prob=null )
  alternativeLikelihood <- exp( lchoose(sum(counts),counts[1]) +
    lbeta(counts[1]+prior[1],counts[2]+prior[2]) - lbeta(prior[1],prior[2]))
  BF <- nullLikelihood / alternativeLikelihood 
  return( BF )
  
}

# The frequentist equivalent is just a chi-square test. This is a 
# "wrapper" function that runs the corresponding test and pulls out
# the p-value
FrequentistGOFTest <- function( counts, null=.5 ){
  
  test <- chisq.test(x=counts,p=c(null,1-null))
  pValue <- test$p.value 
  return( pValue )
  
}


# Let's plot a sequence of p-values and Bayes factors, on the assumption
# that we start testing after 10 observations have arrived (because chi-
# square tests break with too few observations). 
sequentialTesting <- function( n=100, prob=.5, null=.5, prior=c(1,1), stopping=FALSE, plot=TRUE ){
  
  data <- as.numeric( runif( n ) < prob )
  counts <- cumsum(data)
  pValue <- rep.int(NA,n)
  BF <- rep.int(NA,n)
  
  bayesStop <- FALSE
  frequentistStop <- FALSE
  
  for( i in 1:n){
    c <- c(counts[i], i-counts[i]) # successes & failures
    if( !frequentistStop ) {
      pValue[i] <- suppressWarnings( FrequentistGOFTest( c, null ) )
      if( stopping & pValue[i] <.05 ) frequentistStop <- TRUE
    }
    if( !bayesStop ) {
      BF[i] <- BayesianGOFTest( c, null, prior )
      if( stopping & (BF[i] < .05 | BF[i] > 20) ) bayesStop <- TRUE
    }
      

  }
  
  if( plot ){
    
    layout(matrix(1:2,1,2))
    
    # plot the Bayes factor
    minBF <- min( min(BF, na.rm=TRUE), .05 )
    maxBF <- max( max(BF, na.rm=TRUE), 20 )
    ind <- !is.na(BF)
    plot( (1:n)[ind], BF[ind], type="l", log="y", xlab="Number of Observations",
          ylab="BayesFactor", ylim=c(minBF,maxBF), lwd=2, col="blue",
          main="Bayesian evidence for H0", xlim=c(0,n))
    abline( h=.05, lty=2 )
    abline( h=20, lty=2 )
    abline( h=1, lty=2 )
    
    # plot the p-value
    ind <- !is.na(pValue)
    plot( (1:n)[ind], pValue[ind], type="l", xlab="Number of Observations",
          ylab="p-value", ylim=c(0,1), lwd=2, col="red",
          main="Frequentist p-value", xlim=c(0,n))
    abline( h=.05, lty=2 )

    layout(1)
    
  }
  
  out <- cbind( pValue, BF )
  return(invisible(out))
} 


# Let's plot a sequence of p-values, on the assumption
# that we start testing after 10 observations have arrived (because chi-
# square tests break with too few observations). 
sequentialTestingFrequentist <- function( n=100, prob=.5, null=.5, prior=c(1,1), stopping=FALSE, plot=TRUE ){
  
  data <- as.numeric( runif( n ) < prob )
  counts <- cumsum(data)
  pValue <- rep.int(NA,n)
  BF <- rep.int(NA,n)
  
  bayesStop <- FALSE
  frequentistStop <- FALSE
  
  for( i in 1:n){
    c <- c(counts[i], i-counts[i]) # successes & failures
    if( !frequentistStop ) {
      pValue[i] <- suppressWarnings( FrequentistGOFTest( c, null ) )
      if( stopping & pValue[i] <.05 ) frequentistStop <- TRUE
    }
    
  }
  
  if( plot ){
    
    #layout(matrix(1:2,1,2))
    
    # plot the Bayes factor
    #minBF <- min( min(BF, na.rm=TRUE), .05 )
    #maxBF <- max( max(BF, na.rm=TRUE), 20 )
    #ind <- !is.na(BF)
    #plot( (1:n)[ind], BF[ind], type="l", log="y", xlab="Number of Observations",
    #      ylab="BayesFactor", ylim=c(minBF,maxBF), lwd=2, col="blue",
    #      main="Bayesian evidence for H0", xlim=c(0,n))
    #abline( h=.05, lty=2 )
    #abline( h=20, lty=2 )
    #abline( h=1, lty=2 )
    
    # plot the p-value
    ind <- !is.na(pValue)
    plot( (1:n)[ind], pValue[ind], type="l", xlab="Number of Observations",
          ylab="p-value", ylim=c(0,1), lwd=2, col="red",
          main="Frequentist p-value", xlim=c(0,n))
    abline( h=.05, lty=2 )
    
    layout(1)
    
  }
  
  out <- cbind( pValue, BF )
  return(invisible(out))
} 