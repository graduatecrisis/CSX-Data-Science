### Game Board
display = function(position) {
  cat(" ", position[1], "|", position[2], "|", position[3], "\n")
  cat(" ", "----------", "\n")
  cat(" ", position[4], "|", position[5], "|", position[6], "\n")
  cat(" ", "----------", "\n")
  cat(" ", position[7], "|", position[8], "|", position[9], "\n")
  cat("********************", "\n")
}

### Round + A/B Input
Round = function(time) {
  cat("Round", time, "\n")
  if(time %in% c(0, 2, 4, 6, 8)) {
    cat("Now is player A's term!", "\n")
    entry = readline("Player A input(1~9) :")
  } else if(time %in% c(1, 3, 5, 7)) {
    cat("Now is player B's term!", "\n")
    entry = readline("Player B input(1~9) :")
  }
  return(entry)
}

### Exit
if(entry == "exit") {
  cat("Bye-byre!!", "\n")
  break
} else {
  entry = as.numeric(entry)
}

### Inspection
Inspection = function(entry, position) {
  if(entry < 1 | entry > 9) {
    cat("Invalid input! Please re-enter!", "\n")
    occupied = TRUE
  } else if(position[entry] == "O" | position[entry] == "X") {
    cat("This position is already occupied!", "\n")
    occupied = TRUE
  } else {
    occupied = FALSE
  }
  return(occupied)
}

### Input Combine
Input = function(position, time) {
  repeat {
    entry = Round(time)
    
    if(entry == "exit") {
      break
    } else {
      entry = as.numeric(entry)
      occupied = Inspection(entry, position)
    }
    
    if(entry %in% c(1:9) & occupied == FALSE) {
      break
    }
  }
  return(entry)  
}

#### Onboard
if(time %in% c(0, 2, 4, 6, 8)) {
  position[entry] = "O"  
} else if (time %in% c(1, 3, 5, 7, 9)) {
  position[entry] = "X"
}


#### Winning Condition
row_win = function(position) {
  if(position[1] == position[2] & position[2] == position[3]) {
    return(0)
  } else if (position[4] == position[5] & position[5] == position[6]) {
    return(0)
  } else if(position[7] == position[8] & position[8] == position[9]) {
    return(0)
  } else {
    return(1)
  }  
}


col_win = function(position){
  if(position[1] == position[4] & position[4] == position[7]) {
    return(0)
  } else if (position[2] == position[5] & position[5] == position[8]) {
    return(0)
  } else if(position[3] == position[6] & position[6] == position[9]) {
    return(0)
  } else {
    return(1)
  }
}


diag_win = function(position) {
  if(position[1] == position[5] & position[5] == position[9]) {
    return(0)
  } else if (position[3] == position[5] & position[5] == position[7]) {
    return(0)
  }  else {
    return(1)
  } 
}

if(row_win(position) == 0 | col_win(position) == 0 | diag_win(position) == 0) {
  if(time %in% c(0, 2, 4, 6, 8)) {
    cat("Player A wins", "\n")
    break
  } else if (time %in% c(1, 3, 5, 7)) {
    cat("Payer B wins", "\n")
    break
  }
} else if(time == 8) {
  cat("Draw", "\n")
  break
} else {
  time = time + 1
}


### Combine
tic_tac_toe = function(position, time) {
  cat("\014")
  display(position)
  
  repeat {
    entry = Input(position, time)
    if(entry == "exit") {
      cat("Bye-bye!", "\n")
      break
    }
    
    #### Onboard
    if(time %in% c(0, 2, 4, 6, 8)) {
      position[entry] = "O"  
    } else if (time %in% c(1, 3, 5, 7, 9)) {
      position[entry] = "X"
    }
    
    display(position)
    
    #### winning
    if(row_win(position) == 0 | col_win(position) == 0 | diag_win(position) == 0) {
      if(time %in% c(0, 2, 4, 6, 8)) {
        cat("Player A wins!!", "\n")
        break
      } else if (time %in% c(1, 3, 5, 7)) {
        cat("Payer B wins!!", "\n")
        break
      } 
    } else if(time == 8) {
      cat("End in a draw", "\n")
      break
    } else {
      time = time + 1
    }
  }
}

tic_tac_toe(c(1:9), 0)
