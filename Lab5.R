# LABORATORIO 5
library(lubridate)
library(readxl)
library(dplyr)
library(ggplot2)

# Parte 1: Predecir un Eclipse Solar -

eclipse <- ymd_hms("2017-08-21 18:26:40")
synodic_month <- duration(days = 29, hours = 12, minutes = 44, seconds = 3 )
saros <- synodic_month * 223
eclipse_nuevo <- eclipse + saros

# ---------------------------------------------------------------------------

# Parte 2: Agrupaciones y Operaciones con Fechas -

df <- read_excel("lab5.xlsx")

# 1
df$`Fecha Creación` <- dmy(df$`Fecha Creación`)
df$`Fecha Final` <- dmy(df$`Fecha Final`)
df$Mes <- month(df$`Fecha Creación`)

xcodigo <- df[df$Call == 1,]
xcodigo <- xcodigo %>% select(Cod, Call, Mes) %>% group_by(Mes, Cod) %>% summarise(n = n()) %>% arrange(desc(n))
xcodigo <- xcodigo[-1,]

# Todas las llamadas fueron hechas con el codigo de "Actualizacion de Informacion", y los meses que mas llamadas
# tienen son: Mayo con 314, Marzo con 306, y Diciembre con 300.

# 2
df$Dia <- weekdays(df$`Fecha Creación`)
dia_ocu <- df %>% group_by(Dia) %>% summarise(n = n()) %>% arrange(desc(n))
dia_ocu <- dia_ocu[-1,]
dia_ocu[1,]
# Lunes es el dia de la semana mas ocupado con 23135 consultas

# 3
mes_ocu <- df %>% group_by(Mes) %>% summarise(n = n()) %>% arrange(desc(n))
mes_ocu <- mes_ocu[-1,]
# El mes mas ocupado es Marzo con 13813 consultas

# 4
call_mes <- df %>% group_by(Mes) %>% summarise(n = sum(Call)) %>% arrange(desc(n))
call_mes <- call_mes[-1,]
p <- ggplot(call_mes, aes(Mes, n)) +
  geom_line(color = "blue")
p
call_dia <- df %>% group_by(`Fecha Creación`) %>% summarise(n = sum(Call)) %>% arrange(desc(n))
call_dia <- call_dia[-1,]
p2 <- ggplot(call_dia, aes(`Fecha Creación`, n)) +
  geom_line(color = "blue")
p2
# No parece existir ningun tipo de concentracion o estacionalidad en las llamadas

# 5
df$duracion <- df$`Hora Final` - df$`Hora Creación`
df$Duracion_m <- df$duracion/60
dur_prom <- df[df$Call == 1,] %>% summarise(Promedio = mean(Duracion_m))
# La llamada promedio dura alrededor de 14.56 minutos.

# 6
tablaf <- df %>% select(Duracion_m)
tablaf$Duracion_m <- na.omit(as.numeric(tablaf$Duracion_m))
prueba <- hist(tablaf$Duracion_m)
tablaf <- data.frame(Minutos = prueba[[1]][-16], Cantidad = prueba[[2]])

# ----------------------------------------------------------------------------------------------

# Parte 3: Signo Zodiacal
Mi_signo <- function(x){
  zodiacos <-  c("capricornio", "acuario", "piscis", "aries", "tauro", "geminis", "cancer", "leo", "virgo", "libra", "escorpio", "sagitario")
  dia_cambio <- c(20, 19, 20, 20, 21, 21, 22, 22, 22, 22, 22, 21)
  
  dia <- as.numeric(day(x))
  mes <-  as.numeric(month(x))
  
  if (dia > dia_cambio[mes]) 
  {
    mes <- mes + 1
  }
  
  if (mes == 13)
  {
    mes <-  1
  } 
  
  return(paste0("Tu signo es: ",signo[mes]))
}


