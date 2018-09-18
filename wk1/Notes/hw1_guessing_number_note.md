HW\_1 Guessing Number Notes
---------------------------

Use a function `guessing_number` to execute the game. This function will
use `stringr` package to assis on string manipulation. First we break
down the function in several parts:

-   Answer and Basic Settings

-   Count ?A?B

-   Detect Input Error

-   Count Enter times

------------------------------------------------------------------------

### Answer and Basic Settings

Answer should be a 4 digit numbers selected from 0 to 9. However, if we
set Answer as numeric type, we cannot make 0 to be in the beginning.

    Ans = c(0, 3, 4, 5)
    Ans

    ## [1] 0 3 4 5

    Ans_1 = c("0", "3", "4", "5")
    Ans_1

    ## [1] "0" "3" "4" "5"

So we need to store the Ans into *character* type

    Com = as.character(0:9)
    Ans = sample(Com, size = 4)

We also need to specify a `count` variable, where we can use to store
the entry times

    count = 0

------------------------------------------------------------------------

### Count ?A?B

First, we need to specify the entry type to be character, and for
convenience we also limit the *nmax* = 1

    ent = scan("", what = "character", nmax = 1, quiet = TRUE)

The matching logic:

1.  If the ith element of `ent` equals the ith element of `Ans`, then we
    should get an A

2.  **Else**, if the ith element of `ent` equals the jth element of
    `Ans` (where j != i), then we should get an B

<!-- -->

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

------------------------------------------------------------------------

### Detect Input error

-   Input should be 4 digit; otherwise should enter again

<!-- -->

    if(nchar(ent) <= 3 | nchar(ent) >= 5) {
          cat(ent,"Wrong input")
          next
    }

-   4 digit cannot duplicate; otherwise should enter again

<!-- -->

    ent_split = as.vector(str_split(ent, pattern =  "", simplify = TRUE))
    if(any(duplicated(ent_split))) {
          cat(ent, "Duplicated entry")
          next
    }

------------------------------------------------------------------------

### Count Enter Time

Finally we use `repeat` loop to wrap up the process. Every time we
repeat

    count = count + 1

And the break condition would be

    if(A == 4) {
          cat("You're right", "Total answer time:", count)
          break
    }
