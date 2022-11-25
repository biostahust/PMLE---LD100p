# PMLE_LD100p
R code for a point estimation method of the 100p percent lethal dose using a novel penalised likelihood approach.

1. Main function: PMLE.R.
    This function is used to calculate the penalized maximum likelihood estimate for the LD100p.

2. Arguments of the main function
   
    x: dose level (has been log-transformed)
    n: the number of subjects for each dose level
    s: the number of deaths(responses) for each dose level.

3. Example dataset: Beetles Data.txt and Hewlett Data.txt
    This dataset has three columns. The first column is the log-transformed dose level, the second column is the number of subjects for each dose level, 
    and the last column is the number of responses for each dose level.

4. Example code

 ## Read the Beetles data
    Beetles <- read.table("./Beetles Data.txt",header=T)
    x <- Beetles$x
    n <- Beetles$m
    s <- Beetles$s

## Calculate the PMLE for LD50
   PMLE(x=x, n=n, s=s, prob=0.5)
   [1] "The MLE for LD50 is 1.2355. The PMLE for LD50 is 1.2349."

## Calculate the PMLE for LD90
   PMLE(x=x, n=n, s=s, prob=0.9)
   [1] "The MLE for LD90 is 1.7999. The PMLE for LD90 is 1.7506."
