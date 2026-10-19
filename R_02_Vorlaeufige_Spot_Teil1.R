# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --
#
# Name der App                                                              ----
#
# Author : Sascha Kornberger
# Datum  : ${1:`r format(Sys.Date(), "%d.%m.%Y")`}
# Version: 0.1.0
#
# History:
# 0.1.0  Funktion: 
#
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --

# OPTIONS ----------------------------------------------------------------------
# Deaktiviert die die Meldungen der Quellpakete während der Installation.
options(install.packages.check.source = "no")

# Verhindert interaktive CRAN-Mirror-Auswahl
options(repos = c(CRAN = "https://cran.r-project.org"))

# Verhindert die wissenschaftliche Notation für Zahlen.
options(scipen = 999)

# BENOETIGTE PAKETE ------------------------------------------------------------
## Liste der Pakete ----
packages <- c(
  "readxl",
  "fs",
  "tools",
  "logr",
  "dplyr",
  "openxlsx",
  "stringr"
)

## Installiere fehlende Pakete ohne Rückfragen
# Finde alle Pakete die noch nicht installiert sind
installiere_fehlende <- packages[!packages %in% installed.packages()[, "Package"]]

# Installiere nur fehlende Pakete
if (length(installiere_fehlende) > 0) {
  # Installation mit allen Abhängigkeiten
  install.packages(
    installiere_fehlende,
    quiet = TRUE,
    dependencies = TRUE
  )
  # Meldung über Installation
  message(paste("Installiert:", paste(installiere_fehlende, collapse = ", ")))
}

# Alle Pakete laden (ohne Startup-Messages und Versions-Warnungen)
options(warn = -1)
invisible(lapply(packages, function(pkg) {
  suppressPackageStartupMessages(library(pkg, character.only = TRUE))
}))
options(warn = 0)

# RDCOMClient ist nicht in CRAN, daher muss es von GitHub installiert werden
# Prüfen, ob das System Windows ist
if (.Platform$OS.type == "windows") {
  if (!requireNamespace("RDCOMClient", quietly = TRUE)) {
    devtools::install_github("omegahat/RDCOMClient")
  }
  suppressPackageStartupMessages(library(RDCOMClient))
}


# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- -#
# ----                           KONSTANTEN                                 ----
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- -#

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- -#
# ----                             PFADE                                    ----
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- -#

# Hauptpfad
hauptpfad <- "C:/Users/seele/Desktop/Skripte/R_02_Vorlaeufige_Spot_Teil1/R_02_Vorlaeufige_Spot_Teil1"
# Pfad für Ordner mit Kurzfristprognosen
Pfad_01 <- "/01_Input_aus_eSales"
# Pfad für Ordner mit den den Dateien für das PFM
Pfad_02 <- "/02_Export_fuer_PFM"
# pfad für Ordner mit Dateien vom PFM (Berechneten Spot werten)
pfad_03 <- "/03_Input_von_PFM"
# Pfad für Ordner mit Dateien für Kunden
pfad_04 <- "/04_Output_fuer_Kunden"
# pfad für Ordner mit Dateien für Funktionen
pfad_05 <- "/05_Funktionsdateien"
# pfad für Archiv
pfad_06 <- "/06_Archiv"
  
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- -#
# ----                           FUNKTIONEN                                 ----
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- -#

CSV_erstellen <- function(dateipfad, spaltennamen) {
  
  # Leeren Data Frame mit den gewünschten Spalten erzeugen
  df <- as.data.frame(
    setNames(
      replicate(length(spaltennamen), character(0), simplify = FALSE),
      spaltennamen
    )
  )
  
  # Als CSV speichern
  write.csv(
    df,
    file = dateipfad,
    row.names = FALSE,
    fileEncoding = "UTF-8"
  )
  
  message("CSV-Datei erstellt: ", dateipfad)
}

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- -#
# ----                              MAIN                                    ----
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- -#

# Vollständigen Dateinamen zusammensetzen
datei_csv <- file.path(paste0(hauptpfad,Pfad_05), "Werte_Spot_DBA.csv")

# Prüfen, ob die Datei existiert
if (!file.exists(datei_csv)) {
  
  message("CSV-Datei nicht vorhanden. Erstelle Datei ...")
  
  spaltennamen<-c(
                  "Jahr",
                  "Monat",
                  
  )
  
  CSV_erstellen()
  
} else {
  
  message("CSV-Datei vorhanden.")
  
}
