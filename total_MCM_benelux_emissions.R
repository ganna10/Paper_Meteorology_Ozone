# calculate total MCM emissions for benelux
setwd("~/Documents//LaTeX//Meteorology_and_Ozone")
bel <- read.csv("Belgium_MCM_Total_NMVOC_Emissions.csv")
bel[is.na(bel)] <- 0
tbl_df(bel)

lux <- read.csv("Luxembourg_MCM_Total_NMVOC_Emissions.csv")
lux[is.na(lux)] <- 0
tbl_df(lux)

nld <- read.csv("Netherlands_MCM_Total_NMVOC_Emissions.csv")
nld[is.na(nld)] <- 0
tbl_df(nld)
colnames(nld)

benelux <- data.frame(Type = bel$Type, MCM.Species = bel$MCM.species, SNAP.1.Emissions = bel$SNAP.1.Emissions + lux$Snap.1.Emissions + nld$Snap.1.Emissions, SNAP.2.Emissions = bel$SNAP.2.Emissions + lux$Snap.2.Emissions + nld$Snap.2.Emissions, SNAP.34.Emissions = bel$SNAP.34.Emissions + lux$Snap.34.Emissions + nld$Snap.34.Emissions, SNAP.5.Emissions = bel$SNAP.5.Emissions + lux$Snap.5.Emissions + nld$Snap.5.Emissions, SNAP.6.Emissions = bel$SNAP.6.Emissions + lux$Snap.6.Emissions + nld$Snap.6.Emissions, SNAP.71.Emissions = bel$SNAP.71.Emissions + lux$Snap.71.Emissions + nld$Snap.71.Emissions, SNAP.72.Emissions = bel$SNAP.72.Emissions + lux$Snap.72.Emissions + nld$Snap.72.Emissions, SNAP.73.Emissions = bel$SNAP.73.Emissions + lux$Snap.73.Emissions + nld$Snap.73.Emissions, SNAP.74.Emissions = bel$SNAP.74.Emissions + lux$Snap.74.Emissions + nld$Snap.74.Emissions, SNAP.8.Emissions = bel$SNAP.8.Emissions + lux$Snap.8.Emissions + nld$Snap.8.Emissions, SNAP.9.Emissions = bel$SNAP.9.Emissions + lux$Snap.9.Emissions + nld$Snap.9.Emissions, BVOC.Emissions = bel$BVOC.Emissions + lux$BVOC.Emissions + nld$BVOC.Emissions, Total.Emissions = bel$Total.Emissions + lux$Total.Emissions + nld$Total.Emissions)

benelux[benelux == 0] <- NA
tbl_df(benelux)

write.table(benelux, file = "Benelux_MCM_Total_NMVOC_Emissions.csv", row.names = FALSE, sep = ",", quote = FALSE)
