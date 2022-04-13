Titanic Passengers
#Graphically comparing Ticket fares of Class 1 vs Ticket fares of Class 2:

directory <- "/Users/hilarycheng/Downloads"
dirsep <- "/"
filename <- paste(directory, "Titanic.csv", sep=dirsep)
Titanic <- read.csv(filename, header = TRUE, stringsAsFactors = TRUE)

pop <- list(pop1 = subset(Titanic, Titanic$Pclass == 1), pop2 = subset(Titanic, Titanic$Pclass == 2))
par(mfrow=c(1,3),oma=c(0,0,2,0))
qvals <- sort(pop[[1]]$Fare)
pvals <- ppoints(length(qvals))
plot(pvals, qvals, pch = 19, col=adjustcolor("navyblue", alpha = 0.5), xlim=c(0,1), ylim=c(0,520), 
     xlab = "Proportion p", ylab = "Fare", main = "Passenger Class 1")
qvals <- sort(pop[[2]]$Fare)
pvals <- ppoints(length(qvals))
plot(pvals, qvals, pch = 19, col=adjustcolor("red", alpha = 0.5), xlim=c(0,1), ylim=c(0,520), 
     xlab = "Proportion p", ylab = "Fare", main = "Passenger Class 2")
qvals <- sort(pop[[1]]$Fare)
pvals <- ppoints(length(qvals))
plot(pvals, qvals, pch = 19, col=adjustcolor("navyblue", alpha = 0.5), xlim=c(0,1), ylim=c(0,520),
     xlab = "Proportion p", ylab = "Fare", main = "Class 1/Class 2 Units ")
qvals <- sort(pop[[2]]$Fare)
pvals <- ppoints(length(qvals))
points(pvals, qvals, pch = 19, col=adjustcolor("red", alpha = 0.5))

#Numerically comparing Age of passengers in Class 1 vs Age of passengers in Class 2:

summary(pop[[1]]$Age)
summary(pop[[2]]$Age)
mean(pop$pop1[, "Age"], na.rm = TRUE) - mean(pop$pop2[, "Age"], na.rm = TRUE)
sd(pop$pop1[, "Age"], na.rm = TRUE)/sd(pop$pop2[, "Age"], na.rm = TRUE)


#Mixing data randomly to determine if ages of people in Class 1 and Class 2 are similar

mixRandomly <- function(pop) {
  pop1 <- pop$pop1
  n_pop1 <- nrow(pop1)
  pop2 <- pop$pop2
  n_pop2 <- nrow(pop2)
  mix <- rbind(pop1,pop2)
  select4pop1 <- sample(1:(n_pop1 + n_pop2),n_pop1,replace = FALSE)
  new_pop1 <- mix[select4pop1,]  
  new_pop2 <- mix[-select4pop1,]
  list(pop1=new_pop1, pop2=new_pop2)
}
getAveDiffsFn <- function(variate) {
  function(pop) {mean(pop$pop1[, variate], na.rm = TRUE) - mean(pop$pop2[,variate], na.rm = TRUE)}
}
diffAveRES <- getAveDiffsFn("Age")
set.seed(341)
diffRate <- sapply(1:1000, FUN = function(...){ 
  diffAveRES(mixRandomly(pop)) 
  })

hist(diffRate, breaks="FD", prob=TRUE,
     main = "Randomly Mixed Populations", xlab="difference in average",
     col="lightgrey", xlim=c(-10,15))
abline(v=diffAveRES(pop), col = "red", lwd=2)