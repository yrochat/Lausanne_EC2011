library(readr)
library(stringr)
library(dplyr)

verts_apres <- read_csv("verts_suffrages.csv")

colnames(verts_apres)[1] <- "Rang_ap"
colnames(verts_apres)[2] <- "Nom"

verts_avant <- read_lines("verts_liste.txt")

Rang <- as.numeric(str_extract(verts_avant, "(?<=[0-9]{2}\\.)[0-9]{2}"))

Nom <- str_extract(verts_avant, "[[:alpha:]]+ [[[:alpha:]]\\-]+")

verts_avant <- data_frame(Rang_av = Rang, Nom = Nom)

verts <- inner_join(verts_avant, verts_apres, by = "Nom")

plot(verts$Rang_av, verts$Rang_ap, xlab = "Classement sur la liste", ylab = "Classement aux élections", pch = "")
text(verts$Rang_av, verts$Rang_ap, verts$Nom, cex = .5)

plot(verts$Rang_av, verts$Suffrages, xlab = "Classement sur la liste", ylab = "Nombre de suffrages")