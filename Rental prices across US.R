directory <- "/Users/hilarycheng/Downloads"
dirsep <- "/"
filename <- paste(directory, "City_MedianRentalPrice_2Bedroom.csv", sep=dirsep)
RentalPrice <- read.csv(filename, header = TRUE, stringsAsFactors = TRUE)

RentalPrice$difference_2019 = RentalPrice$X2019.12 - RentalPrice$X2019.01
maxdiff_2019 = max(RentalPrice$difference_2019)
maxdiff_2019
```
```{r}
delta = rep(0, length(RentalPrice$difference_2019))
for (i in 1:length(RentalPrice$difference_2019)) {
  delta[i] = maxdiff_2019 - max(RentalPrice$difference_2019[-i])
}

par(mfrow=c(1,2))
plot(delta, main="Influence for Max difference", pch=19, 
     col=adjustcolor("black", alpha = 0.2),
     xlab  = "Index", 
     ylab = bquote(Delta))
plot(RentalPrice$difference_2019, delta, main="Influence for Max difference", pch=19,
     col=adjustcolor("black", alpha = 0.2),
     xlab='Difference in rental price', 
     ylab = bquote(Delta))
