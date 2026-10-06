# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --
#
# vorlaeufige_Spot_BKM                                                              ----
#
# Author : Mathias Seele
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
  "devtools", # RDCOMClient Installer
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
invisible(lapply(required_packages, function(pkg) {
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
# ----                              Pfade                                   ----
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- -#

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- -#
# ----                           FUNKTIONEN                                 ----
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- -#

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- -#
# ----                              MAIN                                    ----
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- -#