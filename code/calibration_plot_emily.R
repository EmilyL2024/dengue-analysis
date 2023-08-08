
### data

### data 1
dengue_data_01 <- read_excel("set-01/dengue-data-01.xls")
modelData <- dengue_data_01

modelData$Lab_Confirmed_Dengue <- ifelse(dengue_data_01$Lab_Confirmed_Dengue ==2, 0, 1)
modelData$dengue <- modelData$Lab_Confirmed_Dengue
modelData <- modelData[-c(which(is.na(dengue$WBC) == "TRUE"), which(is.na(dengue$AST) == "TRUE")),]

modelData <- modelData %>%
  mutate(wbc_1 = WBC, plt_1 = PLT)

### data 7
dengue_7 <- read_excel("/Users/emilyl/Desktop/dengue-analysis/data/set-07/dengue-data-07.xlsx")
dengue7 <- dengue_data_07

dengue7$dengue <- ifelse(dengue7$`FINAL Category` == "Dengue", 1, 0)
colnames(dengue7)[4] <- "Age"
colnames(dengue7)[35] <- "Cat.plt"

dengue7 <- dengue7[-c(1352, 1487), ] ## remove the NA rows from the data set

dengue7 <- dengue7 %>%
  mutate(wbc_1 = WBC, plt_1 = PLT)

### data 10
dengue_data_10 <- read_excel("set-10/dengue-data-10.xlsx")
dengue10 <- dengue_data_10[-c(which(is.na(dengue_data_10$plt)| is.na(dengue_data_10$wbc))),]

### data 13
dengue_data_13 <- read_excel("set-13/dengue-data-13.xlsx")
clean13 <- dengue_data_13

clean13 <- clean13 %>%
  separate(age2, c('Age1', 'Age2'))
clean13$Age1 <- as.numeric(clean13$Age1)
clean13$Age2 <- as.numeric(clean13$Age2)
clean13$Age<- (clean13$Age1 + clean13$Age2)/2

clean13 <- clean13 %>%
  mutate(wbc_1 = wbc_m1*(1/1000), plt_1 = platelets_m1*(1/1000), wbc_3 = wbc_m3/1000, plt_3 = platelets_m3/1000)

### data 17
dengue_data_17 <- read_excel("set-17/dengue-data-17.xls")
dengue17 <- dengue_data_17
dengue17$ConfirmDengue_YesNo_FourCriteria <- ifelse(dengue_data_17$ConfirmDengue_YesNo_FourCriteria =="No dengue", 0, 1)

colnames(dengue17)[2] <- "dengue"
colnames(dengue17)[13] <- "Age"
colnames(dengue17)[73] <- "WBC"
colnames(dengu17)[79] <- "PLT"



## Paper 1

### Paper 1 predict on Paper 10 (0.30 vs. 0.16)
m1 <- glm(dengue ~ Age + PLT + WBC, data=modelData, family=binomial)
YHat_10 <- predict(m1, newdata = dengue10, type = "resp")

calPlot_10 <- cbind(dengue10$dengue, YHat_10)
calPlot_10 <- as.data.frame(calPlot_10)
colnames(calPlot_10)[1] <- "Obs10"
colnames(calPlot_10)[2] <- "Pred10"
calibration_plot(data = calPlot_10, obs = "Obs10", pred =  "Pred10", y_lim = c(0,1))

### Paper 1 predict on Day 1 (0.30 vs. 0.61)
colnames(modelData)[37] <- "wbc_1"
colnames(modelData)[38] <- "plt_1"
m1_d1 <- glm(dengue ~ Age + wbc_1 + plt_1, data=modelData, family=binomial)
YHat1_d1 <- predict(m1_d1, newdata = clean13, type = "resp")

calPlot_d1 <- cbind(clean13$dengue, YHat1_d1)
calPlot_d1 <- as.data.frame(calPlot_d1)
colnames(calPlot_d1)[1] <- "Obs13"
colnames(calPlot_d1)[2] <- "Pred1"
calibration_plot(data = calPlot_d1, obs = "Obs13", pred =  "Pred1", y_lim = c(0,1))

### Paper 1 predict on Day 3 (0.30 vs. 0.61)
colnames(modelData)[37] <- "wbc_3"
colnames(modelData)[38] <- "plt_3"
m1_d3 <- glm(dengue ~ Age + wbc_3 + plt_3, data=modelData, family=binomial)
YHat1_d3 <- predict(m1_d3, newdata = clean13, type = "resp")

calPlot_d3 <- cbind(clean13$dengue, YHat1_d3)
calPlot_d3 <- as.data.frame(calPlot_d3)
colnames(calPlot_d3)[1] <- "Obs13"
colnames(calPlot_d3)[2] <- "Pred1"
calibration_plot(data = calPlot_d3, obs = "Obs13", pred =  "Pred1", y_lim = c(0,1))



## Paper 7

### Paper 7 on Paper 10 (0.31 vs. 0.16)
m7 <- glm(dengue ~ Age + PLT + WBC, data=dengue7, family=binomial)
YHat7_10 <- predict(m7, newdata = dengue10, type = "resp")

calPlot7_10 <- cbind(dengue10$dengue, YHat7_10)
calPlot7_10 <- as.data.frame(calPlot7_10)
colnames(calPlot7_10)[1] <- "Obs10"
colnames(calPlot7_10)[2] <- "Pred10"
calibration_plot(data = calPlot7_10, obs = "Obs10", pred =  "Pred10", y_lim = c(0,1))

### Paper 7 on Day 1 (0.31 vs. 0.61)
colnames(dengue7)[53] <- "wbc_1"
colnames(dengue7)[54] <- "plt_1"

m7 <- glm(dengue ~ Age + wbc_1 + plt_1, data=dengue7, family=binomial)
YHat7_d1 <- predict(m7, newdata = clean13, type = "resp")

calPlot7_d1 <- cbind(clean13$dengue, YHat7_d1)
calPlot7_d1 <- as.data.frame(calPlot7_d1)
colnames(calPlot7_d1)[1] <- "Obs13_1"
colnames(calPlot7_d1)[2] <- "Pred13_1"
calibration_plot(data = calPlot7_d1, obs = "Obs13_1", pred =  "Pred13_1", y_lim = c(0,1))

### Paper 7 on Day 3 (0.31 vs. 0.61)
colnames(dengue7)[53] <- "wbc_3"
colnames(dengue7)[54] <- "plt_3"

m7 <- glm(dengue ~ Age + wbc_3 + plt_3, data=dengue7, family=binomial)
YHat7_d3 <- predict(m7, newdata = clean13, type = "resp")

calPlot7_d3 <- cbind(clean13$dengue, YHat7_d3)
calPlot7_d3 <- as.data.frame(calPlot7_d3)
colnames(calPlot7_d3)[1] <- "Obs13_3"
colnames(calPlot7_d3)[2] <- "Pred13_3"
calibration_plot(data = calPlot7_d3, obs = "Obs13_3", pred =  "Pred13_3", y_lim = c(0,1))



## Paper 10

### Paper 10 on Paper 17 (0.16 vs. 0.45)
m10 <- glm(dengue ~ Age + PLT + WBC, data=dengue10, family=binomial)
YHat10_17 <- predict(m10, newdata = dengue17, type = "resp")

calPlot10_17 <- cbind(dengue17$dengue, YHat10_17)
calPlot10_17 <- as.data.frame(calPlot10_17)
colnames(calPlot10_17)[1] <- "Obs17"
colnames(calPlot10_17)[2] <- "Pred17"
calibration_plot(data = calPlot10_17, obs = "Obs17", pred =  "Pred17", y_lim = c(0,1))

### Paper 10 on Day 1 (0.16 vs. 0.61)
colnames(dengue10)[93] <- "wbc_1"
colnames(dengue10)[100] <- "plt_1"

m10 <- glm(dengue ~ Age + wbc_1 + plt_1, data=dengue10, family=binomial)
YHat10_d1 <- predict(m10, newdata = clean13, type = "resp")

calPlot10_d1 <- cbind(clean13$dengue, YHat10_d1)
calPlot10_d1 <- as.data.frame(calPlot10_d1)
colnames(calPlot10_d1)[1] <- "Obs13"
colnames(calPlot10_d1)[2] <- "Pred13"
calibration_plot(data = calPlot10_d1, obs = "Obs13", pred =  "Pred13", y_lim = c(0,1))

### Paper 10 on Day 3 (0.16 vs. 0.61)
colnames(dengue10)[93] <- "wbc_3"
colnames(dengue10)[100] <- "plt_3"

m10 <- glm(dengue ~ Age + wbc_3 + plt_3, data=dengue10, family=binomial)
YHat10_d3 <- predict(m10, newdata = clean13, type = "resp")

calPlot10_d3 <- cbind(clean13$dengue, YHat10_d3)
calPlot10_d3 <- as.data.frame(calPlot10_d3)
colnames(calPlot10_d3)[1] <- "Obs13"
colnames(calPlot10_d3)[2] <- "Pred13"
calibration_plot(data = calPlot10_d3, obs = "Obs13", pred =  "Pred13", y_lim = c(0,1))



## Paper 13 Day 1

### Day 1 on Paper 1 (0.61 vs. 0.30)
colnames(modelData)[37] <- "wbc_1"
colnames(modelData)[38] <- "plt_1"

m13 <- glm(dengue ~ Age + wbc_1 + plt_1, data=clean13, family=binomial)
YHatd1_1 <- predict(m13, newdata = modelData, type = "resp")

calPlotd1_1 <- cbind(modelData$dengue, YHatd1_1)
calPlotd1_1 <- as.data.frame(calPlotd1_1)
colnames(calPlotd1_1)[1] <- "Obs1"
colnames(calPlotd1_1)[2] <- "Pred1"
calibration_plot(data = calPlotd1_1, obs = "Obs1", pred =  "Pred1", y_lim = c(0,1))

### Day 1 on Paper 10 (0.61 vs. 0.16)
colnames(dengue10)[93] <- "wbc_1"
colnames(dengue10)[100] <- "plt_1"

m13 <- glm(dengue ~ Age + wbc_1 + plt_1, data=clean13, family=binomial)
YHatd1_10 <- predict(m13, newdata = dengue10, type = "resp")

calPlotd1_10 <- cbind(dengue10$dengue, YHatd1_10)
calPlotd1_10 <- as.data.frame(calPlotd1_10 )
colnames(calPlotd1_10)[1] <- "Obs10"
colnames(calPlotd1_10)[2] <- "Pred10"
calibration_plot(data = calPlotd1_10, obs = "Obs10", pred =  "Pred10", y_lim = c(0,1))



## Paper 13 Day 3

### Day 3 on Paper 1 (0.61 vs. 0.30)
colnames(modelData)[37] <- "wbc_3"
colnames(modelData)[38] <- "plt_3"

m13 <- glm(dengue ~ Age + wbc_3 + plt_3, data=clean13, family=binomial)
YHatd3_1 <- predict(m13, newdata = modelData, type = "resp")

calPlotd3_1 <- cbind(modelData$dengue, YHatd3_1)
calPlotd3_1 <- as.data.frame(calPlotd3_1)
colnames(calPlotd3_1)[1] <- "Obs1"
colnames(calPlotd3_1)[2] <- "Pred1"
calibration_plot(data = calPlotd3_1, obs = "Obs1", pred =  "Pred1", y_lim = c(0,1))

### Day 3 on Paper 10 (0.61 vs. 0.16)
colnames(dengue10)[93] <- "wbc_3"
colnames(dengue10)[100] <- "plt_3"

m13 <- glm(dengue ~ Age + wbc_3 + plt_3, data=clean13, family=binomial)
YHatd3_10 <- predict(m13, newdata = dengue10, type = "resp")

calPlotd3_10 <- cbind(dengue10$dengue, YHatd3_10)
calPlotd3_10 <- as.data.frame(calPlotd3_10 )
colnames(calPlotd3_10)[1] <- "Obs10"
colnames(calPlotd3_10)[2] <- "Pred10"
calibration_plot(data = calPlotd3_10, obs = "Obs10", pred =  "Pred10", y_lim = c(0,1))



## Paper 17

### Paper 17 on Paper 10 (0.45 vs. 0.16)
colnames(dengue10)[93] <- "WBC"
colnames(dengue10)[100] <- "PLT"

m17 <- glm(dengue ~ Age + WBC + PLT, data=dengue17, family=binomial)
YHat17_10 <- predict(m17, newdata = dengue10, type = "resp")

calPlot17_10 <- cbind(dengue10$dengue, YHat17_10)
calPlot17_10 <- as.data.frame(calPlot17_10)
colnames(calPlot17_10)[1] <- "Obs10"
colnames(calPlot17_10)[2] <- "Pred10"
calibration_plot(data = calPlot17_10, obs = "Obs10", pred =  "Pred10", y_lim = c(0,1))

### Paper 17 on Day 1 (0.45 vs. 0.61)
colnames(dengue17)[73] <- "wbc_1"
colnames(dengue17)[79] <- "plt_1"

m17 <- glm(dengue ~ Age + wbc_1 + plt_1, data=dengue17, family=binomial)
YHat17_d1 <- predict(m17, newdata = clean13, type = "resp")

calPlot17_d1 <- cbind(clean13$dengue, YHat17_d1)
calPlot17_d1 <- as.data.frame(calPlot17_d1)
colnames(calPlot17_d1)[1] <- "Obs13"
colnames(calPlot17_d1)[2] <- "Pred13"
calibration_plot(data = calPlot17_d1, obs = "Obs13", pred =  "Pred13", y_lim = c(0,1))

### Paper 17 on Day 3 (0.45 vs. 0.61)
colnames(dengue17)[73] <- "wbc_3"
colnames(dengue17)[79] <- "plt_3"

m17 <- glm(dengue ~ Age + wbc_3 + plt_3, data=dengue17, family=binomial)
YHat17_d3 <- predict(m17, newdata = clean13, type = "resp")

calPlot17_d3 <- cbind(clean13$dengue, YHat17_d3)
calPlot17_d3 <- as.data.frame(calPlot17_d3)
colnames(calPlot17_d3)[1] <- "Obs13"
colnames(calPlot17_d3)[2] <- "Pred13"
calibration_plot(data = calPlot17_d3, obs = "Obs13", pred =  "Pred13", y_lim = c(0,1))





