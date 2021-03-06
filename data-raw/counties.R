# load utility functions
source('data-raw/utils.R')

# get state shapefile, tidy, add fips data
counties <- get_shapefile(2016, 'county', '5m') %>%
  tidy(region = "GEOID") %>%
  rename(county_fips = id) %>%
  as_tibble() %>%
  left_join(get_county_fips(), by = "county_fips") %>%
  filter(!state_fips %in% c("60", "66", "69", "72", "78"))

# compress and save
save(counties, file = 'data/counties.rda', compress = 'bzip2')
