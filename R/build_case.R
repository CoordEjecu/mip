#' @export
get_industry_name <- function(metadata) {
  index <- metadata$resources$schema$fields[[1]]$class == "industry"
  industry_name <- metadata$resources$schema$fields[[1]]$name[index]
  return(industry_name)
}
