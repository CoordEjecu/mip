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
