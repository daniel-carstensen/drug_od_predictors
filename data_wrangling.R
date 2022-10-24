library(tidyverse)
library(readxl)

## Wrangle disability rate data

disability_rate <- read_xlsx('raw_state_data/disability_state_2020.xlsx', 'Data')

disability_rate <- disability_rate %>%
  select(-3) %>%
  na.omit() 

names(disability_rate) <- c('state', 'disability_rate')

disability_rate <- disability_rate %>%
  mutate(state = replace(state, state == 'U.S.', 'United States'))


## Wrangle education level data

education_level <- read_xlsx('raw_state_data/education_state_county_1970_2020.xlsx')

education_level <- education_level %>%
  select(c(1:3, 52:55)) %>%
  filter(substring(`Federal Information Processing Standards (FIPS) Code`, 3, 5) == '000') %>%
  select(-6)

names(education_level) <- c('fips', 'state_abbrv', 'state', 'no_hs_rate', 'only_hs_rate', 'college_rate')

education_level <- education_level %>%
  filter(!(state_abbrv %in% c('PR'))) %>%
  mutate(state = replace(state, state == 'Lousiana', 'Louisiana'))


## Wrangle drug od rate

drug_od_rate <- read_csv('raw_state_data/drug_overdose_deaths_state_2020.csv')

drug_od_rate <- drug_od_rate %>%
  mutate(State = replace(State, is.na(drug_od_rate$State), 'United States'),
         `State Code` = replace(`State Code`, is.na(drug_od_rate$`State Code`), 0))

names(drug_od_rate) <- c('state', 'fips', 'od_deaths', 'population', 'od_death_rate')


## Wrangle debt rate

debt_rate <- read_csv('raw_state_data/household_debt_state_1999_2022.csv')

debt_rate <- debt_rate %>%
  filter(year == 2020) %>%
  group_by(state_fips) %>%
  summarise(mean_low_debt_rate = mean(low, na.rm = TRUE)) %>%
  summarise(fips = state_fips, mean_low_debt_rate)


## Wrangle insurance rate

insurance_rate <- read_csv('raw_state_data/insurance_rate_state_county_2020.csv')

insurance_rate <- insurance_rate %>%
  filter(geocat == 40,
         agecat == 0,
         racecat == 0,
         sexcat == 0,
         iprcat == 0) %>%
  select(statefips, NUI, NIC, PCTUI, PCTIC, state_name) %>%
  rename(fips = statefips, number_uninsured = NUI, number_insured = NIC, uninsurance_rate = PCTUI,
         insurance_rate = PCTIC, state = state_name)


## Wrangle median income data

median_income <- read_csv('raw_state_data/median_income_state_2020.csv', skip = 1)

us_median_income = pull(median_income[1,2])

median_income <- median_income %>%
  select(state = Name, median_income = '2020') %>%
  mutate(deviation_us_median_income = median_income - us_median_income,
         state = replace(state, state == 'The United States', 'United States'))

## Wrangle unemployment rate

unemployment_rate <- read_csv('raw_state_data/unemployment_state_2020.csv')

us_mean_unemployment <- pull(unemployment_rate[1,2])
names(unemployment_rate) <- c('state', 'unemployment_rate')

unemployment_rate <- unemployment_rate %>%
  select(state, unemployment_rate) %>%
  mutate(deviation_us_unemployment_rate = unemployment_rate - us_mean_unemployment) %>%
  na.omit()


## Wrangle income inequality data

inequality <- read_csv('raw_state_data/ACSDt5Y2020.B19083-Data.csv', skip = 1)

names(inequality) <- c('fips', 'state', 'gini')

inequality <- inequality %>%
  select(fips, state, gini) %>%
  filter(nchar(fips) == 11,
         state != 'Puerto Rico') %>%
  mutate(fips = substring(fips, 10, 11))


## Wrangle poverty data

poverty <- read_csv('raw_state_data/ACSST5Y2020.S1701-Data.csv', skip = 1)

poverty <- poverty %>%
  select(fips = Geography,
         state = `Geographic Area Name`,
         poverty_rate = `Estimate!!Percent below poverty level!!Population for whom poverty status is determined`) %>%
  filter(nchar(fips) == 11,
        state != 'Puerto Rico') %>%
  mutate(fips = substring(fips, 10, 11))


## Join all data

full_df <- drug_od_rate %>%
  full_join(median_income, by = 'state') %>%
  full_join(inequality, by = 'state') %>%
  full_join(poverty, by = 'state') %>%
  full_join(unemployment_rate, by = 'state') %>%
  full_join(insurance_rate, by = 'state') %>%
  full_join(education_level, by = 'state') %>%
  full_join(disability_rate, by = 'state') %>%
  select(-fips.x, -fips.x.x, -fips.y.y, -fips) %>%
  rename(fips = fips.y) %>%
  select(fips, state_abbrv, state, population, everything()) %>%
  full_join(debt_rate, by = 'fips')


## Write full_df into csv file

write_csv(full_df, 'full_state_data.csv')
