library(jsonlite)
json_file <- "/workdir/tests/data/datatable.json"
metadata <- fromJSON(json_file)

describe("set up", {
  it("get industry name", {
    expected_name <- c("agricultura", "mineria", "energia_agua_gas", "contruccion", "actividades_gubernamentales")
    obtained_name <- get_industry_name(metadata)
    expect_equal(obtained_name, expected_name)
  })
})

demand <- tibble::tibble(
  "demanda_final" = c(2, 4, 6),
  "cprv" = c(1, 2, 3),
  "cg" = c(0, 0, 0),
  "fbkf" = c(0, 0, 0),
  "existencias" = c(0, 0, 0),
  "exportaciones" = c(1, 2, 3)
)

describe("Change final demands", {
  it("change exports: factor 1", {
    expected_demand <- c(2, 4, 6)
    obtained_demand <- change_exports(demand, 1.0)
    expect_equal(obtained_demand, expected_demand)
  })
  it("change exports: factor 0.5", {
    expected_demand <- c(1.5, 3, 4.5)
    obtained_demand <- change_exports(demand, 0.5)
    expect_equal(obtained_demand, expected_demand)
  })
  it("change exports: factor 0.1", {
    expected_demand <- c(1.1, 2.2, 3.3)
    obtained_demand <- change_exports(demand, 0.1)
    expect_equal(obtained_demand, expected_demand)
  })
})

describe("Calcualte percentaje changed", {
  it("Changed 10%", {
    originan_demand <- c(100, 100, 100)
    changed_demand <- c(110, 110, 110)
    expected_percentaje <- c(10, 10, 10)
    obtained_percentaje <- percentaje_changed(originan_demand, changed_demand)
    expect_equal(obtained_percentaje, expected_percentaje)
  })
})
