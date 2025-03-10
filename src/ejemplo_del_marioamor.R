library(tidyverse)

mip_df <- read_csv("datos/conjunto_de_datos_mip_cdi_ixi_12018.csv", show_col_types = FALSE, col_types = cols(.default = "d", Concepto = "c")) |>
  mutate(moderado = `CPrv - Consumo privado` + `CG - Consumo de gobierno` + `P.51b - Formación bruta de capital fijo` + `P.52 - Variación de existencias` + 0.9*`a P.6 - Exportaciones de bienes y servicios`)

all_concepts <- mip_df |>
  pull(Concepto)

industrias <- all_concepts[1:20]

mip_industrias <- mip_df |>
  select(industrias)

clean_mip_industrias <- mip_industrias[1:20,]
produccion <- all_concepts[32]

total_produccion <- mip_df|>
filter(Concepto == produccion)

demanda_intermedia <- total_produccion[,4:23]|> as.numeric()

transacciones_intermedias <- mip_industrias[1:20,]

insumo_producto <- t(t(transacciones_intermedias)/demanda_intermedia)

liontief <- diag(20)- insumo_producto

liontief_inv <- solve(liontief)

demanda_final <- mip_df[1:20, 24] * c(1.1, rep(1,19))

demanda_intermedia_teo <- liontief_inv%*%demanda_final |>
  unname()

# Primer escenario
demanda_final_mod <- mip_df[1:20, 31]|> pull()

demanda_intermedia_teo <- liontief_inv%*%demanda_final_mod |>
  unname()