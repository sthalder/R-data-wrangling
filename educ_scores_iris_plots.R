#
#R graphics

#read education data
educ<-read.table ('D:/MS BANA/Fall sem/Stat Computing 6043/Class 7/EDUC_SCORES.txt',header=TRUE,row.names="ID")

#attach the dataset first

attach(educ)

#histogram of geometric variable

hist(geometric)

#scatterplot
plot(analytical, geometric)

#identify points inthe plot
identify(analytical, geometric, row.names(educ))


#scatterplot matrix
pairs(cbind(language,analytical, geometric))

pairs(cbind(language,analytical, geometric), panel=function(x,y)
 {points(x,y)
 abline(lm(y~x), lty=2)},
 diag.panel=function(x)
 {par(new=T)
 hist(x,main="",axes=F,nclass=10)})



#attach iris data
attach(iris)

#look at the top 6 rows
head(iris)

#horizontal box plot od sepal length 
boxplot(Sepal.Length, horizontal=T)

summary(Sepal.Length)

boxplot(iris[,1:4])

#embellish the output with titles
boxplot (iris[,1:4], horizontal=T, main='Iris Flower Data', xlab='Measurements in mm')

#divide frame into 2 rows and 2 cloumns with 4 spaces at top for title
par(mfrow=c(2,2), oma = c(0,0,2,0))

#create four histogram separately
 for (i in 1:4)
 {
 hist(iris[,i],main=colnames(iris[i]), col="blue", xlab="")
 }

#put text on the outer margin
mtext(side=3, "Iris Flowers Data\n Measurements in mm", outer=T)

#create a density plot for the four variables
for (i in 1:4)
{
plot(density(iris[,i]),main=colnames(iris[i]), col="red", ylab="Density")
}
#write the margin text at the top
mtext(side=3, "Density Estimates of Iris Flower Data\n Measurements in mm", outer=T)

#load library MASS for accessing mammals data
library(MASS)

#look at the first 6 rows
head(mammals)

help(mammals)

#reset the partition to a single graph
par(mfrow=c(1,1))

#plot the two variables
plot(mammals$body,mammals$brain)

#identify the outlying points
identify(mammals$body,mammals$brain,labels=row.names(mammals))

#attach the data for easy access to variables
attach(mammals)

#plot the logaritms of body weight and brain weight
plot(log(body), log(brain), col="blue", xlab ="Log(Body Weight)", ylab = "Log(Brain Weight)",  main="Scatter Plot of Mammals Data")


#create a regression object to store results
lmReg <- lm(log(brain)~log(body))

#do a summary of lmReg to look at results
summary(lmReg)

#add the regression line to the previous scatter plot
abline(lmReg, col="red")

#add the regression equation as a legend
legend("bottomright", legend="log(Brain Weight)=2.12+0.75*log(Body Weight)", col="blue")

#add a legend on model fit
legend("topleft", legend="Adjusted R-square=0.92", col="blue")

#identify a few points on either side of the line
identify(log(body),log(brain),labels=row.names(mammals))

#look at regression diagnostic plots

#partition the frame into 2 by 2
par(mfrow=c(2,2))

#plot the regression diagnostics
plot(lmReg)

#identify the points showing up in the diagnostic plots
print(mammals[32:35,])


##################################################
#######  multivariate graphics ###################
##################################################

#reading US air pollution data
USairpoll <- read.table('C:/Users/narayaa.BUSINESS/Documents/Statistical Programming BANA/Class 7/USairpollution.txt',header=T)

head(USairpoll)

##################scatter plot imbedded with rug plots

#create labels for x & y axes
xlabel <- "Manufacturing sites with 20 or more workers"
ylabel <- "Population size in 000s (1970 census)"

#attach the data for easy access
attach(USairpoll)


#reset the partition to a single graph
par(mfrow=c(1,1))

plot(Manuf, Pop, xlab=xlabel, ylab=ylabel, main = "US Air Pollution Data", pch=9)
#add a least squares line
abline(lsfit(Manuf,Pop))

#add a rug for the x-axis
rug(Manuf, ticksize = 0.03, side = 1, lwd = 0.5, col="blue")

#add a rug for the x-axis
rug(Pop, ticksize = 0.03, side = 2, lwd = 0.5, col="blue")

#identify some points on the graph
identify(Manuf,Pop,labels=row.names(USairpoll))

########## scatterplot with marginal boxplots and histogram #################

###### need the fig option in par command ################
help(par)

##################scatter plots with marginal box plots and histogram
#set the plotting area for scatter plot to be 70%
par(fig=c(0.0, 0.7,0.0,0.75))
#draw the scatterplot
plot(Manuf, Pop, main = "", pch=9)

#add a least squares line
abline(lsfit(Manuf,Pop))

#add locally weighted regression fit
lines(lowess(Manuf,Pop),col="red")

#set the plotting area for the histogram of x-variable
par(fig=c(0.0, 0.7,0.6,1.0),new=TRUE)
hist(Manuf,xlab="",main="US Air Pollution Data")

#set the plotting area for the boxplot of y-variable
par(fig=c(0.6, 1.0, 0.0, 0.75),new=TRUE)
boxplot(Pop)


#reset the partition to a single graph
par(mfrow=c(1,1))


##########bivariate box plot
# load Everit  & Hothorn's MVA package
library("MVA")

#extract the needed matrix for bivariate box plot
bvboxData <- USairpoll[,c("Manuf", "Pop")]

#print the bvboxdata
print(bvboxData)

#draw the bivariate box plot
bvbox(bvboxData, mtitle = "Bivariate Boxplot", xlab=xlabel,ylab=ylabel)

#identify the "outlier" points
identify(Manuf,Pop,labels=row.names(bvboxData))


########## compute impact of outliers on correlation

#identify outliers and create an object
outliers <- match(c("Chicago", "Philadelphia", "Detroit", "Cleveland"), 
rownames(bvboxData))

#print the row numbers
print(outliers)

#correlation with all data
with(USairpoll, cor(Manuf, Pop))

#correlation after removing outliers
with(USairpoll, cor(Manuf[-outliers], Pop[-outliers]))

#alternatively, you could have done as follows
with(USairpoll, cor(Manuf[-c(11,18,27,29)], Pop[-c(11,18,27,29)]))

############################bubble plot 

#plot a scatter plot first
plot(Temp, Wind, 
xlab="Average Annual Temperature (F)", 
ylab="Average Annual Wind Speed(mph)", 
main="Bubble Plot", pch=10)

#add  the bubble according to SO2 values
symbols(Temp, Wind, circles=SO2, inches=0.5, add=TRUE)

#identify some cities
identify(Temp,Wind,labels=row.names(USairpoll))


#############################star plots
stars(USairpoll,cex=0.65)

######## scatterplot matrix


############ a plain scatterplot

pairs(USairpoll)

######## a little better
pairs(USairpoll, 
      diag.panel=function(x)
      {par(new=T)
       hist(x,main="",axes=F,nclass=10)} )

pairs(USairpoll, panel=function(x,y)
{points(x,y)
 abline(lm(y~x), lty=2, col="blue")},
      diag.panel=function(x)
      {par(new=T)
       hist(x,main="",axes=F,nclass=10)})

#compute the correlation matrix
cor(USairpoll)

#compute the correlation matrix
cor(USairpoll)

#################3-D plots ############

#load the scatterplot3d library

library("scatterplot3d")

#plot the 3-d
scatterplot3d(Temp, Wind, SO2, type="h", angle=55, pch=25, grid=T, main="3-D Scatterplot")