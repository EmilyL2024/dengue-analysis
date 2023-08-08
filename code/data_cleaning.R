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
