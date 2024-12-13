library(tidyverse)
library(forcats)
library(readxl)

historical_spending <- read_csv("./data/tidytuesday-2024-02-13/historical_spending.csv")
historical_spending_labels <- levels(as_factor(historical_spending$Year))
historical_spending$Year <- factor(historical_spending$Year, levels = historical_spending_labels)

only_categories <- historical_spending |> select(-any_of(c("PercentCelebrating", "PerPerson")))

#only_categories <- historical_spending |> select(c("Year", "Candy", "Flowers", "Jewelry"))

longer <- only_categories |> pivot_longer(!Year, names_to = "Category", values_to = "Percentage")
category_labels <- levels(as_factor(longer$Category))
longer$Category <- factor(longer$Category, levels = category_labels)
glimpse(longer)
ggplot(longer, aes(x = Year, y = Percentage, fill = Category)) +
    geom_bar(stat = "identity", position = "fill", width = 0.5) +
    labs(title = "Average % Spending by Category", x = "Category", y = "Average % Spending") +
    theme_minimal()


