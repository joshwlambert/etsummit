# create Colombia department codes data

col_departs <- data.frame(
  name = c("Amazonas", "Antioquia", "Arauca", "Atlántico", "Bogotá D.C.",
           "Bolívar", "Boyacá", "Caldas", "Caquetá", "Casanare", "Cauca",
           "Cesar", "Chocó", "Córdoba", "Cundinamarca", "Guainía", "Guaviare",
           "Huila", "La Guajira", "Magdalena", "Meta", "Nariño",
           "Norte de Santander", "Putumayo", "Quindío", "Risaralda",
           "San Andrés", "Santander", "Sucre", "Tolima", "Valle del Cauca",
           "Vaupés", "Vichada"),
  code = c("91", "05", "81", "08", "11", "13", "15", "17", "18", "85", "19",
           "20", "27", "23", "25", "94", "95", "41", "44", "47", "50", "52",
           "54", "86", "63", "66", "88", "68", "70", "73", "76", "97", "99"),
  region = c(NA, "CO-ANT", NA, NA, NA, NA, "CO-BOY", "CO-CAL", NA, NA, NA, NA,
             NA, NA, "CO-CUN", NA, NA, "CO-HUI", NA, NA, NA, NA, "CO-NSA",
             NA, "CO-QUI", "CO-RIS", NA, "CO-SAN", NA, "CO-TOL", NA, NA, NA)
)

# the next rule requires the working directory to be the package root (needs updating to be wd agnostic)
saveRDS(col_departs, file = file.path("inst", "epiCo", "col_departs.rds"))






