# Notes: 
# - the script assumes that results.csv is in the working directory, which isn't great practice!! :-)
# - the script doesn't know what's in each field, so it treats everything as text: user needs to convert as needed
# - the map and reduce functions are part of the purrr package in tidyverse, and very cool

# Use tidyverse
library(tidyverse)

# read the data in a tidier form
my_data <- read_csv("results.csv") %>%                  # read the raw file
  pull("content") %>%                                   # retain only the content vector
  map(read_csv, col_types = cols(.default = "c")) %>%   # map each element to a tibble 
  reduce(bind_rows)                                     # take the list of tibbles and collapse to one tibble

# write to a tidy file
my_data %>% write_csv("tidy_results.csv")
