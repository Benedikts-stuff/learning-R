library(tidyverse)
library(forcats)
library(readxl)
library(hrbrthemes)

historical_spending <- read_csv("./data/tidytuesday-2024-02-13/historical_spending.csv")
historical_spending_labels <- levels(as_factor(historical_spending$Year))
historical_spending$Year <- factor(historical_spending$Year, levels = historical_spending_labels)

ggplot(historical_spending, aes(x = historical_spending$Year, y = historical_spending$PerPerson), group = 1) +
    geom_bar(stat = "identity", position = "dodge", width=0.5) +
    labs(title = "Average Spending on Valentine's Day by Year", x = "Year", y = "Average Spending per Person") +
    theme_minimal()

only_categories <- historical_spending |> select(-any_of(c("PercentCelebrating", "PerPerson")))

#only_categories <- historical_spending |> select(c("Year", "Candy", "Flowers", "Jewelry"))

longer <- only_categories |> pivot_longer(!Year, names_to = "Category", values_to = "Percentage")
category_labels <- levels(as_factor(longer$Category))
longer$Category <- factor(longer$Category, levels = category_labels)
glimpse(longer)
ggplot(longer, aes(x = Year, y = Percentage, fill = Category)) +
    geom_bar(stat = "identity", position = "stack", width = 0.5) +
    theme_minimal()
