#' @export
get_industry_name <- function(metadata) {
  index <- metadata$resources$schema$fields[[1]]$class == "industry"
  industry_name <- metadata$resources$schema$fields[[1]]$name[index]
  return(industry_name)
}

#' @export
change_exports <- function(demand, factor) {
  new_demand <- demand |>
    dplyr::mutate(final_demand = cprv + cg + fbkf + existencias + factor * exportaciones) |>
    dplyr::pull(final_demand)
  return(new_demand)
}

percentaje_changed <- function(original_demand, changed_demand) {
  percentaje <- (changed_demand - original_demand) / original_demand * 100
  return(percentaje)
}
