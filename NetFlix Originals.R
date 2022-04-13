NetFlix Originals 
#A graphical visualization of your choosing that summarizes the population

directory <- "/Users/hilarycheng/Downloads"
dirsep <- "/"
filename <- paste(directory, "NetflixOriginals.csv", sep=dirsep)
NetflixOriginals <- read.csv(filename, header = TRUE, stringsAsFactors = TRUE)
par(mfrow=c(1,2))
hist(NetflixOriginals$IMDB.Score, main = "IMDB Score", ylab="Score", xlab="Frequency")
hist(NetflixOriginals$Runtime, main = "Runtime", ylab="Minutes", xlab="Frequency")

#Top 5 most produced genres of Netflix Original Films

kable(sort(table(NetflixOriginals$Genre), decreasing = TRUE)[1:5])

#Plot of the average IMDB scores of the top 5 produced genres

Doc_sub = subset(NetflixOriginals, NetflixOriginals$Genre =="Documentary")
Dra_sub = subset(NetflixOriginals, NetflixOriginals$Genre =="Drama")
Com_sub = subset(NetflixOriginals, NetflixOriginals$Genre =="Comedy")
RomCom_sub = subset(NetflixOriginals, NetflixOriginals$Genre =="Romantic comedy")
Thr_sub = subset(NetflixOriginals, NetflixOriginals$Genre =="Thriller")

plot(x = 1, type = "n", xaxt='n', xlim = c(0, 6), ylim = c(0, 10), pch = 16, xlab = "", 
     ylab = "IMDB score", main = "Average IMDB scores of the top 5 most produced genres")
points(1,mean(Doc_sub$IMDB.Score), pch=19)
points(2,mean(Dra_sub$IMDB.Score), pch=19)
points(2.9,mean(Com_sub$IMDB.Score), pch=19)
points(4.2,mean(RomCom_sub$IMDB.Score), pch=19)
points(5.5,mean(Thr_sub$IMDB.Score), pch=19)
text(x=c(1,2,2.9,4.2,5.5),  pos=3, cex = 0.65, y=c(mean(Doc_sub$IMDB.Score),mean(Dra_sub$IMDB.Score),
                               mean(Com_sub$IMDB.Score),mean(RomCom_sub$IMDB.Score),
                               mean(Thr_sub$IMDB.Score)), 
     labels= c(paste("(Documentary, ", format(formatC(mean(Doc_sub$IMDB.Score))), ")", sep=""),
               paste("(Drama, ", format(formatC(mean(Dra_sub$IMDB.Score))), ")", sep=""),
               paste("(Comedy, ", format(formatC(mean(Com_sub$IMDB.Score))), ")", sep=""),
               paste("(Romantic Comedy, ", format(formatC(mean(RomCom_sub$IMDB.Score))), ")", sep=""),
               paste("(Thriller, ", format(formatC(mean(Thr_sub$IMDB.Score))), ")", sep="")))