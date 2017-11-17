set.seed(1234)

nyc_inspections = read_csv("./DOHMH_New_York_City_Restaurant_Inspection_Results.csv.gz", col_types = cols(building = col_character()), na = c("NA", "N/A"))

nyc_inspections %>%
  sample_n(5000) %>% 
  clean_names() %>%
  select(camis, boro, critical_flag, cuisine_description, inspection_date, score, grade) %>% 
  mutate(cuisine_description = ifelse(cuisine_description == "CafÃ©/Coffee/Tea", "Cafe/coffee/Tea", cuisine_description)) %>%
  filter(grade %in% c("A", "B", "C"), boro != "Missing") %>% 
  mutate(boro = str_to_title(boro)) %>%
  filter(inspection_date > "1900-01-01") %>%
  write_csv("/home/katya/Documents/Data_Science_1/p8105_hw6_kb2908/shinyapp/nyc_inspections.csv")

nyc_inspections %>% 
  count(cuisine_description, sort = TRUE) %>% 
  top_n(10) %>% 
  select(cuisine_description) %>% 
  write_csv("/home/katya/Documents/Data_Science_1/p8105_hw6_kb2908/shinyapp/cuisine_list.csv")