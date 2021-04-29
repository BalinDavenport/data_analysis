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

# mutate() function adds new columns to a data frame
msleep %>% 
    mutate(rem_proportion = sleep_rem/sleep_total) %>% 
    head()
# mutate() can add several new columns (separated by commas)
msleep %>% 
    mutate(rem_poportion = sleep_rem/sleep_total,
           bodywt_grams = bodywt * 1000) %>% 
    head
# 
# practice
#
msleep %>% 
    mutate(rem_proportion = sleep_rem/sleep_total,
           bodywt_grams = bodywt * 1000) %>% 
    select(name, order, rem_proportion, bodywt_grams) %>% 
    arrange(desc(bodywt_grams)) %>% 
    head
# 
# using summarise() to create summary statistics
msleep %>% 
    summarise(avg_sleep = mean(sleep_total))
# there are many summarise funcitions such as: sd(), min(),max(),sum(),
# n()(returns the length of a vector)n_distinct()(number of distinct number
# in a vector)
msleep %>% 
    summarise(avg_sleep = mean(sleep_total),
              min_sleep = min(sleep_total),
              distinct = n_distinct(sleep_total),
              total = n())

# group_by verb allows spliting a datafram by some variable, apply a function
# to those individual frames and then combine them.

msleep %>% 
    group_by(order) %>% 
    summarise(avg_sleep = mean(sleep_total),
              min_sleep = min(sleep_total),
              max_sleep = max(sleep_total),
              total = n())
