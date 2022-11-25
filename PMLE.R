## Main function
PMLE <- function(x, n, s, prob = 0.5){
  
  if(prob < 0 | prob > 1) stop("The probability of being affected should be between 0 and 1.")

  lambda <- 1
  
  q <- log(prob/(1-prob))
  m <- glm(cbind(s,n-s) ~ x,binomial(link = "logit"))
  
  beta0hat <- m$coefficients[[1]]
  betahat <- m$coefficients[[2]]
  v1 <- summary(m)$cov.scaled[1,1]
  v2 <- summary(m)$cov.scaled[2,2]
  v12 <- summary(m)$cov.scaled[1,2]
  cov <- matrix(c(v1,v12,v12,v2), nrow=2, ncol=2)
  
  alphahat <- beta0hat - q
  gammahat <-  -alphahat/betahat
  
  X <- matrix(c(rep(1,length(x)), x), nrow=length(x), ncol=2)
  phi <- 1/(1+exp(-(betahat*x + beta0hat)))
  h <- phi*(1 - phi)*(v1 + 2*v12*x + v2*x^2)
  b <- cov%*%t(X)%*%(n*h*(phi-0.5))
  b1 <- b[1,]
  b2 <- b[2,]
  
  alpha_BC <- alphahat - b[1,]
  beta_BC <- betahat - b[2,]
  
  betatilde <- beta_BC/2 + sign(beta_BC)*sqrt(beta_BC^2/4 + lambda*v2)
  alphatilde <- alpha_BC + (v12/v2)*(betatilde - beta_BC)
  gammatilde <- -alphatilde/betatilde
  
  MLE = round(gammahat,4); PMLE = round(gammatilde,4)
  
  return(paste("The MLE for LD", prob*100, " is ", MLE, ". ", 
               "The PMLE for LD", prob*100, " is ", PMLE, ".", sep=""))
}

## Read the Beetles data
Beetles <- read.table("./Beetles Data.txt",header=T)

x <- Beetles$x
n <- Beetles$m
s <- Beetles$s

## Calculate the PMLE for LD50
PMLE(x=x, n=n, s=s, prob=0.5)

## Calculate the PMLE for LD90
PMLE(x=x, n=n, s=s, prob=0.9)
