#Were the sales affected by COVID-19 pandemic policies in Italy, Greece, Bulgaria, Hungary, Romania, Poland, and Russia?


directory <- "/Users/hilarycheng/Downloads"
dirsep <- "/"
filename <- paste(directory, "WBCOVID_data.csv", sep=dirsep)
WBCOVID_data <- read.csv(filename, header = TRUE, stringsAsFactors = TRUE)

na = WBCOVID_data[!is.na(WBCOVID_data$COVb2a),]
COVID_dataClean = na[!(na$COVb2a == -9 | na$COVb2a == -99),]
CountrySubset = list(Italy = subset(COVID_dataClean, COVID_dataClean$Country=="Italy"),
                     Greece = subset(COVID_dataClean, COVID_dataClean$Country=="Greece"),
                     Bulgaria = subset(COVID_dataClean, COVID_dataClean$Country=="Bulgaria"),
                     Hungary = subset(COVID_dataClean, COVID_dataClean$Country=="Hungary"),
                     Romania = subset(COVID_dataClean, COVID_dataClean$Country=="Romania"),
                     Poland = subset(COVID_dataClean, COVID_dataClean$Country=="Poland"),
                     Russia = subset(COVID_dataClean, COVID_dataClean$Country=="Russian Federation"))


#I am going to conduct a hypothesis test to determine whether sales were affected by COVID-19 pandemic policies in Italy, Greece, Bulgaria, Hungary, Romania, Poland, and Russia. I have chosen to ignore all the rows that contains NA, -9, and -99 in column 'COVb2a' to provide a more conclusive result. My null hypothesis is that COVID-19 pandemic policies did not affect sales in the above countries and my alternative hypothesis is that COVID-19 pandemic policies did affect sales.



#Hypothesis Testing for Italy

a <- 2
s <- sd(CountrySubset$Italy$COVb2a)
n <- nrow(CountrySubset$Italy)
xbar <- mean(CountrySubset$Italy$COVb2a)
z <- (xbar-a)/(s/sqrt(n))
2*pnorm(-abs(z))


#Hypothesis Testing for Greece

a <- 2
s <- sd(CountrySubset$Greece$COVb2a)
n <- nrow(CountrySubset$Greece)
xbar <- mean(CountrySubset$Greece$COVb2a)
z <- (xbar-a)/(s/sqrt(n))
2*pnorm(-abs(z))


#Hypothesis Testing for Bulgaria

a <- 2
s <- sd(CountrySubset$Bulgaria$COVb2a)
n <- nrow(CountrySubset$Bulgaria)
xbar <- mean(CountrySubset$Bulgaria$COVb2a)
z <- (xbar-a)/(s/sqrt(n))
2*pnorm(-abs(z))


#Hypothesis Testing for Hungary

a <- 2
s <- sd(CountrySubset$Hungary$COVb2a)
n <- nrow(CountrySubset$Hungary)
xbar <- mean(CountrySubset$Hungary$COVb2a)
z <- (xbar-a)/(s/sqrt(n))
2*pnorm(-abs(z))


#Hypothesis Testing for Romania

a <- 2
s <- sd(CountrySubset$Romania$COVb2a)
n <- nrow(CountrySubset$Romania)
xbar <- mean(CountrySubset$Romania$COVb2a)
z <- (xbar-a)/(s/sqrt(n))
2*pnorm(-abs(z))


#Hypothesis Testing for Poland

a <- 2
s <- sd(CountrySubset$Poland$COVb2a)
n <- nrow(CountrySubset$Poland)
xbar <- mean(CountrySubset$Poland$COVb2a)
z <- (xbar-a)/(s/sqrt(n))
2*pnorm(-abs(z))


#Hypothesis Testing for Russia**

a <- 2
s <- sd(CountrySubset$Russia$COVb2a)
n <- nrow(CountrySubset$Russia)
xbar <- mean(CountrySubset$Russia$COVb2a)
z <- (xbar-a)/(s/sqrt(n))
2*pnorm(-abs(z))


#I made the assumption that the data follows a normal distribution and we can see that the p-values of all the above countries, is less than $\alpha = 0.05$ which indicates that we can reject the null hypothesis that COVID-19 pandemic policies had no affect on small and medium sized business sales. So we can conclude with a 5% level of significance that COVID-19 pandemic policies affected business sales. 


#Were the effects of COVID-19 pandemic policies on sales similar between countries?

#More specifically, I am going to look at whether the % decrease in sales are similar between countries because the mean of the answers recorded in COVb2a are closer to 3, which indicates that in general, there has been a decrease in sales due to the COVID-19 pandemic. 

#Italy vs Greece

pop <- list(pop1 = subset(COVID_dataClean, COVID_dataClean$Country == "Italy" & COVID_dataClean$COVb2a == 3), pop2 = subset(COVID_dataClean, COVID_dataClean$Country == "Greece" & COVID_dataClean$COVb2a == 3))

mixRandomly <- function(pop) {
    pop1 <- pop$pop1
    n_pop1 <- nrow(pop1)
    
    pop2 <- pop$pop2
    n_pop2 <- nrow(pop2)
    
    mix <- rbind(pop1, pop2)
    select4pop1 <- sample(1:(n_pop1 + n_pop2), n_pop1, replace = FALSE)
    
    new_pop1 <- mix[select4pop1, ]
    new_pop2 <- mix[-select4pop1, ]
    list(pop1 = new_pop1, pop2 = new_pop2)
}

getAveDiffsFn <- function(variate) {
    function(pop) {
        mean(pop$pop1[, variate]) - mean(pop$pop2[, variate])
    }
}

getSDRatioFn <- function(variate) {
    function(pop) {
        sd(pop$pop1[, variate])/sd(pop$pop2[, variate])
    }
}

diffAveLengths <- getAveDiffsFn("COVb2c")
ratioSDLengths <- getSDRatioFn("COVb2c")

set.seed(341)
mixedPop <- mixRandomly(pop)

diffLengths <- sapply(1:5000, FUN = function(...) {
    diffAveLengths(mixRandomly(pop))
})

hist(diffLengths, breaks = 20, main = "Randomly Mixed Populations from Italy & Greece", xlab = "difference in averages", 
    col = "lightgrey")
abline(v = diffAveLengths(pop), col = "red", lwd = 2)


#By looking at a randomly mixed population, I can determine whether the % decrease in sales are similar between Italy and Greece. The red line indicates the difference betwen the average % decrease in Italy and Greece. As we can see from the histogram, the redline seems to be extreme relative to the randomly mixed differences. So there appears to be a significant difference in average % decrease in sales with Italy having a greater % decrease than Greece. 


#Poland vs Russia

popPR <- list(pop1 = subset(COVID_dataClean, COVID_dataClean$Country == "Poland" & COVID_dataClean$COVb2a == 3), pop2 = subset(COVID_dataClean, COVID_dataClean$Country == "Russian Federation" & COVID_dataClean$COVb2a == 3))

set.seed(341)
mixedPop <- mixRandomly(pop)

diffLengths <- sapply(1:5000, FUN = function(...) {
    diffAveLengths(mixRandomly(popPR))
})

hist(diffLengths, breaks = 20, main = "Randomly Mixed Populations from Poland & Russia", xlab = "difference in averages", 
    col = "lightgrey", xlim = c(-10,10))
abline(v = diffAveLengths(popPR), col = "red", lwd = 2)


#The red line indicates the difference betwen the average % decrease in Poland and Russia As we can see from the histogram, the redline seems to be extreme relative to the randomly mixed differences. So there appears to be a significant difference in average % decrease in sales with Russia having a greater % decrease than Poland. 

#Hungary vs Romania

popHR <- list(pop1 = subset(COVID_dataClean, COVID_dataClean$Country == "Hungary" & COVID_dataClean$COVb2a == 3), pop2 = subset(COVID_dataClean, COVID_dataClean$Country == "Romania" & COVID_dataClean$COVb2a == 3))

set.seed(341)
mixedPop <- mixRandomly(pop)

diffLengths <- sapply(1:5000, FUN = function(...) {
    diffAveLengths(mixRandomly(popHR))
})

hist(diffLengths, breaks = 20, main = "Randomly Mixed Populations from Hungary and Romania", xlab = "difference in averages", 
    col = "lightgrey")
abline(v = diffAveLengths(popHR), col = "red", lwd = 2)

#The red line indicates the difference betwen the average % decrease in Hungary and Romania. As we can see from the histogram, the redline seems to be extreme relative to the randomly mixed differences. So there appears to be a significant difference in average % decrease in sales with Romania having a greater % decrease than Hungary. 

#Conclusion: The affect of COVID-19 pandemic policies on sales aren’t similar between countries
