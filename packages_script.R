# Saves a list of packages installed in your old 
# device (from your old device

installed <- as.data.frame(installed.packages())

write.csv(installed, 'installed_previously.csv')

# Create a list of libraries from your old list that 
# were not already installed when you freshly download R 
installedPreviously <- read.csv('installed_previously.csv')

baseR <- as.data.frame(installed.packages())

toInstall <- setdiff(installedPreviously, baseR)

# Install the previously installed libraries

install.packages(toInstall)
