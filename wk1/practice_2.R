### practice_2
### course_grade


# Create a vector called course.students.number, with data: c(1, 30)
course.student.number = c(1, 30)
  
# Create a variable csn, with data: length of course.student.number
csn = length(course.student.number)
  
# Create a vector course.student.grade, with sample() function: x = c(55:100), size = csn
course.student.grade =  sample(x = c(55:100), size = csn)
  
# Assign course.student.number as names of the course.student.grade
names(course.student.grade) <- course.student.number

# Create csg.mean, with the mean value of course.student.grade
csg.mean = mean(course.student.grade)
  
# Create csg.max with the max value of course.student.grade
csg.max = max(course.student.grade) 
  
# Create csg.min with the min value of course.student.grade
csg.min = min(course.student.grade) 
  
# Create a vector csg.over.80, with the logical result of course.student.grade over 80
csg.over.80 = course.student.grade >= 80

# Check csg.over.mean
csg.over.mean = course.student.grade > csg.mean

# Filter the course.student.grade with csg.over.80
course.student.grade[csg.over.80]
# Filter the course.student.grade with csg.over.mean
course.student.grade[csg.over.mean]

# Print course information
print(paste("痁计:", csn))
print(paste("痁キА", csg.mean))
print(paste("痁程蔼", csg.max))
print(paste("痁程", csg.min))

# Print over 80 details
print(paste("蔼80だ羆计", length(course.student.grade[csg.over.80])))

# Print student numbers that are over 80; if not, print 'No one'
if (length(course.student.grade[csg.over.80]) == 0) {
  print("No one")
} else {
  print(paste("蔼80だ畒腹", names(course.student.grade[csg.over.80])))
}

