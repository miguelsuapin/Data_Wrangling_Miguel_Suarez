library(readr)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(highcharter)

df2 <- read_csv("c1.csv")

# LIMPIEZA DE DATOS 

df2$Fecha <- as.Date(x = df2$Fecha, format = "%d-%m-%y")
df2$Camion_5 <- gsub("Q-", NA, df2$Camion_5)
df2$Camion_5 <- as.numeric(gsub("Q", "", df2$Camion_5))
df2$Pickup <- gsub("Q-", NA, df2$Pickup)
df2$Pickup <- as.numeric(gsub("Q", "", df2$Pickup))
df2$Moto <- gsub("Q-", NA, df2$Moto)
df2$Moto <- as.numeric(gsub("Q", "", df2$Moto))                     
df2$factura <- as.numeric(gsub("Q", "", df2$factura))                        
df2$directoCamion_5 <- gsub("Q-", NA, df2$directoCamion_5)
df2$directoCamion_5 <- as.numeric(gsub("Q", "", df2$directoCamion_5))
df2$directoPickup <- gsub("Q-", NA, df2$directoPickup)
df2$directoPickup <- as.numeric(gsub("Q", "", df2$directoPickup))
df2$directoMoto <- gsub("Q-", NA, df2$directoMoto)
df2$directoMoto <- as.numeric(gsub("Q", "", df2$directoMoto))
df2$fijoCamion_5 <- gsub("Q-", NA, df2$fijoCamion_5)
df2$fijoCamion_5 <- as.numeric(gsub("Q", "", df2$fijoCamion_5))
df2$fijoPickup <- gsub("Q-", NA, df2$fijoPickup)
df2$fijoPickup <- as.numeric(gsub("Q", "", df2$fijoPickup))
df2$fijoMoto <- gsub("Q-", NA, df2$fijoMoto)
df2$fijoMoto <- as.numeric(gsub("Q", "", df2$fijoMoto))

# CREAR UNA TABLA RESUMIDA

resumen <- data.frame(matrix(nrow = nrow(df2)))
resumen$vehiculo <- NA
resumen$vehiculo[which(!is.na(df2$Camion_5))] <- "camion"
resumen$vehiculo[which(!is.na(df2$Pickup))] <- "pickup"
resumen$vehiculo[which(!is.na(df2$Moto))] <- "moto"
resumen <- resumen[-1]
resumen$factura <- df2$factura
resumen$costo_directo <- NA
resumen$costo_directo[which(!is.na(df2$Camion_5))] <- df2$directoCamion_5[which(!is.na(df2$Camion_5))]
resumen$costo_directo[which(!is.na(df2$Pickup))] <- df2$directoPickup[which(!is.na(df2$Pickup))]
resumen$costo_directo[which(!is.na(df2$Moto))] <- df2$directoMoto[which(!is.na(df2$Moto))]
resumen$costo_fijo <- NA
resumen$costo_fijo[which(!is.na(df2$Camion_5))] <- df2$fijoCamion_5[which(!is.na(df2$Camion_5))]
resumen$costo_fijo[which(!is.na(df2$Pickup))] <- df2$fijoPickup[which(!is.na(df2$Pickup))]
resumen$costo_fijo[which(!is.na(df2$Moto))] <- df2$fijoMoto[which(!is.na(df2$Moto))]
resumen$utilidad <- resumen$factura - (resumen$costo_directo + resumen$costo_fijo)

# ESTADO DE RESULTADOS BREVE DEL 2017
estado_resultados17 <- data.frame(t(data.frame(Ventas = sum(resumen$factura),
                                  Costo_Ventas = sum(resumen$costo_directo + resumen$costo_fijo),
                                  Utilidad_Operacion = sum(resumen$utilidad))))
names(estado_resultados17) <- "ER17"

# COMO QUEDO EL TARIFARIO EN 2017 POR UNIDAD
df2$vehiculo <- resumen$vehiculo
tarifario <- df2 %>% select(Cod,vehiculo,Camion_5,Pickup,Moto) %>% group_by(Cod) %>% summarise(camion = sum(Camion_5,na.rm = TRUE),pickup = sum(Pickup,na.rm = TRUE),moto = sum(Moto,na.rm = TRUE))
ggplot(data = tarifario, mapping = aes(x = Cod)) +
  geom_col(aes(y = camion, color = "red")) +
  geom_col(aes(y = pickup, color = "blue")) +
  geom_col(aes(y = moto, color = "yellow")) +
  theme(axis.text.x = element_text(angle = 90)) +
  ylab(label = "Costo")

 # LAS TARIFAS ACTUALES SON ACEPTABLES?
aceptables <- df2 %>% select(Fecha, Cod) %>% group_by(Fecha, Cod) %>% summarise(n = n())
ggplot(data = aceptables, mapping = aes(x = Fecha, y = n, fill = Cod)) +
  geom_line()
# Lo importante en esta grafica es notar que ninguna de las lineas parece tener una pendiente negativa con el tiempo
# indicando que los precios estan bien
# Ademas, viendo que nuestros costos no superan el retorno de cada operacion, no estamos en numeros rojos.
# Con esta misma grafica podemos observar que no es necesario abrir mas centros de distribucion ya que nuestra
# demanda permanece estable a lo largo del año sin tener picos, lo cual SI nos obligaria a tener 
# mas centros. 

# 80-20
ochenta20 <- df2 %>% select(factura, Cod) %>% group_by(Cod) %>% summarise(total = sum(factura))
ggplot(data = ochenta20, mapping = aes(x = Cod, y = total)) +
  geom_col() +
  theme(axis.text.x = element_text(angle = 90))
# Aqui podemos observar como el mayor porcentaje proviende del area de revision.
# se recomienda tener contrataciones de personal y equipo que sean equivalentes a estas proporciones para minimizar costos

