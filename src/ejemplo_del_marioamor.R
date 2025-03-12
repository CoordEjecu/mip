library(tidyverse)
library(jsonlite)
library(mip)
json_file <- "/workdir/datos/datatable.json"
metadata <- fromJSON(json_file)

mip_df <- read_csv("datos/conjunto_de_datos_mip_cdi_ixi_12018.csv", show_col_types = FALSE, col_types = cols(.default = "d", concepto = "c"))

all_concepts <- mip_df |>
  pull(concepto)

industrias <- get_industry_name(metadata)

mip_industrias <- mip_df |>
  select(all_of(industrias))

clean_mip_industrias <- mip_industrias[1:20, ]
produccion <- all_concepts[32]

total_produccion <- mip_df |>
  filter(concepto == produccion)

demanda_intermedia <- total_produccion[, 4:23] |> as.numeric()

transacciones_intermedias <- mip_industrias[1:20, ]

insumo_producto <- t(t(transacciones_intermedias) / demanda_intermedia)

liontief <- diag(20) - insumo_producto

liontief_inv <- solve(liontief)

just_industries_rows <- mip_df[1:20, ]
# Primer escenario
demanda_final <- mip::change_exports(just_industries_rows, 1.0)

demanda_intermedia <- liontief_inv %*% demanda_final

demanda_final_settup_1 <- mip::change_exports(just_industries_rows, 0.70)

demanda_intermedia_1 <- liontief_inv %*% demanda_final_settup_1

percentaje_changed <- mip::percentaje_changed(demanda_intermedia, demanda_intermedia_1)
print("Cambio en la demanda intermedia por exportacion:")
print(percentaje_changed)

factor_fbkf <- c(1.1, rep(1, 19))
demanda_final_changed_fbkf <- mip::change_fbkf(just_industries_rows, factor_fbkf)

demanda_intermedia_fbkf <- liontief_inv %*% demanda_final_changed_fbkf
percentaje_changed_fbkf <- mip::percentaje_changed(demanda_intermedia, demanda_intermedia_fbkf)
print("Cambio en la demanda intermedia por fbkf:")
print(percentaje_changed_fbkf)
