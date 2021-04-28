library(dplyr)

msleep <- read.csv("dplyr/msleep_ggplot2.csv")
head(msleep)
# select columns name, and sleep total
sleep_data <- select(msleep, name, sleep_total)
head(sleep_data)
# select colums except using "-"
head(select(msleep, -name))
# a range of columns using ":"
head(select(msleep, name:order))
# columns with the character string "sl", using starts_with()
# can also use ends_with(), contains(),one_of() and matches()
head(select(msleep, starts_with("sl")))

# Selecting rows using filter
filter(msleep,sleep_total >= 16)
filter(msleep,sleep_total >= 16, bodywt >= 1)
filter(msleep, order %in% c("Perissodactyla", "Primates"))
# bolean operators > < >= <= != %in% all work to create logical tests

# pipe %>% ctrl+shift+m allows reading of functions from left to right
head(select(msleep, name, sleep_total))
# vs
msleep %>% 
    select(name, sleep_total) %>% 
    head
# this becomes very useful when combining many functions

# arrange rows by column
msleep %>% 
    arrange(order) %>% 
    head
# select and arrange 3 columns
msleep %>% 
    select(name, order, sleep_total) %>% 
    arrange(order, sleep_total) %>% 
    head
# same as above but uses filter to grab only rows for animals that sleep more 
# than 16 hours
msleep %>% 
    select(name, order, sleep_total) %>% 
    arrange(order, sleep_total) %>% 
    filter(sleep_total >= 16)
# arranges the rows in the sleep_total column in descending order using desc()
msleep %>% 
    select(name, order, sleep_total) %>% 
    arrange(order, desc(sleep_total)) %>% 
    filter(sleep_total >= 16)
