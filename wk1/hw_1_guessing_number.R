# 猜數字遊戲
# 基本功能
# 1. 請寫一個由"電腦隨機產生"不同數字的四位數(1A2B遊戲)
# 2. 玩家可"重覆"猜電腦所產生的數字，並提示猜測的結果(EX:1A2B)
# 3. 一旦猜對，系統可自動計算玩家猜測的次數

# 額外功能：每次玩家輸入完四個數字後，檢查玩家的輸入是否正確(錯誤檢查)

library(stringr)

guessing_number = function() {
  Com = as.character(0:9)
  Ans = sample(Com, size = 4, replace = FALSE)
  count = 0
  print("Please enter non_replicate 4 digit number from 0 to 9")
  repeat {
    ent = scan("", what = "character", nmax = 1, quiet = TRUE)
    ent_split = as.vector(str_split(ent, pattern =  "", simplify = TRUE))
    
    ## Count entry times
    count = count + 1
    
    ## Enter error detection
    if(nchar(ent) <= 3 | nchar(ent) >= 5) {
      cat(ent,"Wrong input")
      next
    }
    if(any(duplicated(ent_split))) {
      cat(ent, "Duplicated entry")
      next
    }
    
    ## ?A?B
    A = 0
    B = 0
    for(i in 1:4) {
      if(substr(ent, i, i) == Ans[i]) {
        A = A + 1
      } else {
        for(j in 1:4) {
          if(substr(ent, i, i) == Ans[j]) {
            B = B + 1
          }
          j = j + 1
        }
      }
      i  = i + 1
    }
    cat(ent, " ", A, "A", B, "B\n", sep = "")
    if(A == 4) {
      cat("You're right", "Total answer time:", count)
      break
    }
  }
}

guessing_number()
  

