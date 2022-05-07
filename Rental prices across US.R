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

#We can see one very clear influential point where the average rent for a 2 bedroom apartment increased by more than \$600 over 2019. Upon further investigation, the region is Siesta Key in Florida. More specifically monthly rent increased by \$650. It makes sense that the most influential point to the maximum difference in rent over 2019 is the region with the largest difference. By removing this point, the maximum increase in rental price is $615. 

#I can think of a couple of reasons why the average monthly rent increase in Siesta Key is the most influential point to the attribute max:

#- Siesta Key is right by the beach along the coast of Florida, making it an area with incredible views and attractive real estate
#- There is also a reality tv show called Siesta Key that takes place in the region which may have increased its publicity
