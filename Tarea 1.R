# Strings 
string <- "This is a string"
class(string)
length(string)
nchar(string)

# Double 
number <- 234

class(number)
typeof(number)
length(number)

number_2 <- 1/8
number_2

# Integer 
integer <- 2L
class(integer)

# Logico 
logical <- TRUE 

class(logical)

logical*1

as.logical(0)
as.logical(1)

# Vectores 
num_vector <- c(1,2,3,4)
length(num_vector)

num_vector_2 <- c(1,2,3,4,"a")
num_vector_2

vec1 <- 1:100
vec2 <- sample(x = 1:10, size = 5, replace = FALSE)
vec2
vector("integer", length = 10)


class(num_vector)
class(num_vector_2)

c(num_vector, 5,6,7,8)
c(num_vector_2, 5,6,7,8)

log_vec <- c(F, F, T)
class(log_vec)

as.numeric(num_vector_2)

# Factor 
factor_1 <- c("mon", "tue", "wed", "mon")
factor_1 <- factor(factor_1)
factor_1

# Ordered Factor 
factor_2 <- c("mon", "tue", "wed", "mon")
factor_2 <- ordered(factor_2, levels = c("mon", "tue", "wed"))
factor_2                    

# Listas 
vector1 <- c(1,2,3,4,5)
vector2 <- c(F, F, T)
vector3 <- letters[1:6]

list_1 <- list(vector1, vector2, vector3)
list_1
list_1[[2]]

names(list_1) <- c("a", "b", "c")
list_1

# Matriz 
mat <- matrix(1:10, nrow = 2, ncol = 5)
mat[2,] #Indexing 

c(1,2,3,4,5)[c(1,3:5)]

a <- c(1,2,3,4,5,4,5,4,5)
condicion <- a>=4
a[#codicion]
  condicion
  a[condicion]
  
  a[a>=4]    
  
  # Data Frames 
  
  df <- data.frame(
    col1 = c("this", "is", "a", "vector", "of", "strings"),
    col2 = 1:6,
    col3 = letters[1:6],
    stringsAsFactors = FALSE 
  )
  
  View(df)
  str(df)
  
  df[1,]
  df[,3]
  
  names(df)
  names(df) <- c("column1", "column2", "column3")
  
  head(df, 2)
  tail(df, 3)
  
  nrow(df)
  ncol(df)
  
  names(df)[2:3] <- c("c2", "c3")
  df
  
  # Functions of Base R (ufunc)
  
  num_vector_3 <- as.numeric(num_vector_2)
  is.na(num_vector_3)
  num_vector_3[!is.na(num_vector_3)]
  
  mean(num_vector_3, na.rm = TRUE)
  mean(num_vector_3[!is.na(num_vector_3)])
  
  df_copy <- data.frame(
    col1 = c("this", "is", "a", "vector", "of", "strings"),
    col2 = 1:6,
    col3 = letters[1:6],
    stringsAsFactors = FALSE
  )
  
  df_copy[!is.na(df_copy$col2), ]

  
  