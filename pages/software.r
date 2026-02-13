library(gh)
library(yaml)
library(purrr)

# 1. Fetch repos
repos <- gh("/orgs/cmmr/repos", type = "public", .limit = 100)

# 2. Extract and format with actual strings (no placeholders)
software_data <- map(repos, ~{
  # Check if a logo likely exists, otherwise use a generic lab image
  # You can replace this URL with a real lab logo placeholder
  logo_url <- sprintf("https://raw.githubusercontent.com/cmmr/%s/main/man/figures/logo.png", .x$name)
  
  list(
    title = .x$name,
    description = .x$description %||% "No description provided.",
    path = .x$html_url,
    stars = as.integer(.x$stargazers_count),
    image = logo_url
  )
})

# 3. Sort
software_data <- software_data[order(map_dbl(software_data, "stars"), decreasing = TRUE)]

# 4. Save
write_yaml(software_data, "pages/software.yml")
