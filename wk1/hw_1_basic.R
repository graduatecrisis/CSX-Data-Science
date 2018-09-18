### hw_1_question


########################################################### Task 1

# 查看內建資料集: 鳶尾花(iris)資料集
iris

# 使用dim(), 回傳iris的列數與欄數
dim(iris)

# 使用head() 回傳iris的前六列
head(iris)

# 使用tail() 回傳iris的後六列
tail(iris)

# 使用str() 
str(iris)

# 使用summary() 查看iris敘述性統計、類別型資料概述。
summary(iris)

########################################################### Task 2

# 使用for loop 印出九九乘法表
# Ex: (1x1=1 1x2=2...1x9=9 ~ 9x1=9 9x2=18... 9x9=81)
A = matrix(rep(0, 81), nrow = 9)

for(i in 1:9) {
  for(j in 1:9) {
    A[i, j] = i * j
    j = j + 1
  }
  i = i + 1
}


########################################################### Task 3

# 使用sample(), 產出10個介於10~100的整數，並存在變數 nums
nums = sample(10:100, size = 10)

# 查看nums
nums

# 1.使用for loop 以及 if-else，印出大於50的偶數，並提示("偶數且大於50": 數字value)
# 2.特別規則：若數字為66，則提示("太66666666666了")並中止迴圈。
for(i in 1:10) {
  if(nums[i] == 66) {
    print(paste("太66666666666了", nums[i]))
    break
  } else if(nums[i] > 50 & nums[i] %% 2 == 0) {
    print(paste("偶數且大於50", nums[i]))
  } 
  i = i + 1
}

## Potential error when nums[i] == 66: missing value where TRUE/FALSE needed



########################################################### Task 4

# 請寫一段程式碼，能判斷輸入之西元年分 year 是否為閏年

leap_year = function() {
  print("Please enter a year from 1 to 9999")
  year = array(scan(""))
  for(i in 1:length(year)) {
    if(year[i] <= 0) {
      cat(year[i], "Please enter a positive number\n")
    } else if (year[i] >= 10000) {
      cat(year[i], "We can't live that longer\n")
    } else if (year[i] %% 400 == 0 | (year[i] %% 4 == 0 & year[i] %% 100 != 0)) {
      cat(year[i], "is a leap year\n")
    } else {
      cat(year[i],"is not a leap year\n")
    }
  }
}

leap_year()