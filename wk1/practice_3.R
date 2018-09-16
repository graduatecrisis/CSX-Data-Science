### practice_3
### ptt_info_book

# 基本變數資訊
person.name <- c("Jiyuian", "Shawnroom", "Bigmoumou")
person.sex <- c("F", "M", "M")
person.id <- c("jiyuian520", "shawnn520", "moumou123")
person.days <- c(201, 37, 99)

# 使用data.frame()，並以上述4個向量建立person.df
person.df = data.frame(person.name, person.sex, person.id, person.days)
  
# 使用str()查看person.df結構
str(person.df)  
  
# 使用summary()查看person.df summary
summary(person.df)  

# Turn Factor into characters(person.name & person.id)
person.df$person.name = as.character(person.df$person.name)
person.df$person.id = as.character(person.df$person.id)

# 印出person.df
person.df  
  
# 印出person.df第一列
person.df[1, ]

# 印出person.df第二列第三欄
person.df[2, 3]

# 查看person.df中person.id欄位(使用$)
person.df$person.id

# 使用order()將person.df$person.days排序後, 建立days.position
days.postion = order(person.df$person.days)
  
# 使用days.postion, 排序person.df(save as different dataframe)
person.df.1 = person.df[days.postion, ]

# 使用grepl()，找出person.df$person.id中有520精神的
spirit.520 = grepl("520", person.df.1$person.id)

# 篩選出520家族的成員
person.df.1[spirit.520, ]

# Use grep to find person.id with "520" and print them out
person.df.1[grep("520", person.df.1$person.id), ]