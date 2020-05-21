###############################################################################
# 05_script.R
###############################################################################



# Prerequisites -----------------------------------------------------------

# load packages
library(tidyverse)

# data set we'll use today
mpg



# Canvas ------------------------------------------------------------------

# blank canvas
ggplot(data = mpg)

# canvas with axes defined
ggplot(data = mpg, aes(x = displ, y = hwy))



# Geoms -------------------------------------------------------------------

# univariate geoms, numeric variables
ggplot(data = mpg, aes(x = hwy)) +
  geom_histogram()
ggplot(data = mpg, aes(x = hwy)) +
  geom_freqpoly()
ggplot(data = mpg, aes(x = hwy)) +
  geom_density()

# univariate geoms, categorical variables
ggplot(data = mpg, aes(x = class)) +
  geom_bar()

# bivariate geoms
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point()
ggplot(data = mpg, aes(x = class, y = hwy)) +
  geom_boxplot()
ggplot(data = mpg, aes(x = class, y = hwy)) +
  geom_violin()


# your turn!
#1
ggplot(data = mpg, aes(x = cty)) +
  geom_histogram()

#2
ggplot(data = mpg, aes(x = manufacturer)) +
  geom_bar()

#3
mpg %>% 
  ggplot(aes(x = displ, y = cty)) + geom_point()

ggplot(data = mpg, aes(x = displ, y = cty)) +
  geom_point()


# non-mapping aesthetics
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "blue", size = 2, shape = 17, alpha = .5)
?pch

# adding a third dimension
## all points blue
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "blue")
## points color based on vehicle class
ggplot(data = mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point()

# a common error
ggplot(data = mpg, aes(x = displ, y = hwy, color = "blue")) +
  geom_point()


# your turn!
#1
?mpg
glimpse(mpg)

#2
mpg %>% ggplot(aes(x = displ, y = cty)) +
  geom_point(color = "blue", size = 2, shape = 17, alpha = .5)


#3
mpg %>% ggplot(aes(displ, cty, color = drv, shape = drv)) +
  geom_point()


#4
mpg %>% ggplot(aes(x = displ, y = cty)) +
  geom_point(color = "blue", size = 2, shape = 17, alpha = .5, stroke = 5)

#5
mpg %>% ggplot(aes(x = displ, y = cty, color = displ < 5)) +
  geom_point()



# Facets ------------------------------------------------------------------

# example of facet wrap
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_wrap(~ class, nrow = 2)

# example of facet grid
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_grid(drv ~ cyl)


# your turn!
#1
ggplot(data = mpg, aes(x = displ, y = cty)) + 
  geom_point() + 
  facet_wrap(~ year, nrow = 1)

#2
ggplot(data = mpg, aes(x = displ, y = cty)) + 
  geom_point() + 
  facet_grid(year ~ cyl)

#3
ggplot(data = mpg, aes(x = displ, y = cty)) + 
  geom_point() + 
  facet_grid(cyl ~ year)


#4
ggplot(data = mpg, aes(x = displ, y = cty)) + 
  geom_point() + 
  facet_grid(~ year + cyl)

ggplot(data = mpg, aes(x = displ, y = cty)) + 
  geom_point() + 
  facet_grid(~ cyl + year, nrow = 2)

#5
ggplot(mpg, aes(displ, cty)) +
  geom_point() +
  facet_grid(year ~ cyl, scales = "free", space = "free")



# Overplotting ------------------------------------------------------------

# layering helps display patterns
mpg %>%
  ggplot(aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

mpg %>%
  ggplot(aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth()

mpg %>%
  ggplot(aes(x = displ, y = hwy)) + 
  geom_point(aes(shape = drv)) + 
  geom_smooth(aes(color = drv))

# layering helps identify abnormalities
mpg %>%
  ggplot(aes(x = displ, y = hwy)) + 
  geom_point(aes(color = class)) + 
  geom_smooth()

mpg %>%
  ggplot(aes(x = displ, y = hwy)) + 
  geom_point(aes(color = class == "2seater")) + 
  geom_smooth(data = filter(mpg, class == "2seater"), se = FALSE) + 
  geom_smooth(data = filter(mpg, class != "2seater"), se = FALSE)


# your turn!
#1
ggplot(data = mpg, aes(x = class, y = hwy)) + 
  geom_boxplot() +
  geom_jitter(width = .2, alpha = .5) 

#2
ggplot(data = mpg, aes(x = displ, y = cty)) + 
  geom_smooth() +
  geom_rug()


# Positioning -------------------------------------------------------------

# positioning with bar charts
ggplot(data = mpg, aes(class, color = factor(year))) + 
  geom_bar()

ggplot(data = mpg, aes(class, fill = factor(year))) + 
  geom_bar()

ggplot(data = mpg, aes(class, fill = factor(year))) + 
  geom_bar(position = "fill")
ggplot(data = mpg, aes(class, fill = factor(year))) + 
  geom_bar(position = "dodge")


# your turn!
ggplot(data = mpg, aes(class, fill = factor(cyl))) + 
  geom_bar(position = "fill")

# ggplot(data = mpg, aes(class, fill = factor(cyl))) +
#   geom_bar(position = "dodge")
# 
# ggplot(data = mpg, aes(class, fill = factor(cyl))) +
#   geom_bar()
?geom_bar

# Coordinate system -------------------------------------------------------

# coord_flip() to flip axes
ggplot(data = mpg, aes(x = class, y = hwy)) + 
  geom_boxplot()
ggplot(data = mpg, aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()

# zoom in/out with coord_cartesian()
ggplot(data = mpg, aes(x = displ, y = cty)) + 
  geom_jitter() +
  coord_cartesian(xlim = c(4, 7), ylim = c(10, 20))

# format axes and labels
ggplot(data = txhousing, aes(x = volume, y = median)) + 
  geom_point(alpha = .25) +
  scale_y_continuous(name = "Median Sales Price", labels = scales::dollar) +
  scale_x_log10(name = "Total Sales Volume", labels = scales::comma) +
  ggtitle("Texas Housing Sales",
          subtitle = "Sales data from 2000-2010 provided by the TAMU real estate center")

# create polar charts
ggplot(data = mpg, aes(class, fill = factor(year))) + 
  geom_bar() +
  coord_polar()


# your turn!
ggplot(data = mpg, aes(class, fill = factor(cyl))) + 
  geom_bar(position = "fill") +
  scale_y_continuous(name = "Percent", labels = scales::percent) +
  coord_flip()
