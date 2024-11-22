library(tidyverse)
library(forcats)
library(readxl)

gifts_age <- read_csv("./data/tidytuesday-2024-02-13/gifts_age.csv")
gifts_gender <- read_csv("./data/tidytuesday-2024-02-13/gifts_gender.csv")
historical_spending <- read_csv("./data/tidytuesday-2024-02-13/historical_spending.csv")

age_labels <- as_factor(gifts_age$Age) %>% levels()
gifts_age$Age <- as.factor(gifts_age$Age)
gifts_age$Age <- as.numeric(gifts_age$Age)

for (i in colnames(gifts_age)) {
    if (i == "Age") {
        next
    }

    #   TODO: fix it
    model <- print(i) %>% lm(Age ~ ., data = gifts_age)
    ggplot(model, mapping = aes(x = Age, y = i)) +
        # labs(title = "Age vs " + column, x = "Age", y = column) +
        scale_x_continuous(breaks = seq(1, 6, 1), labels = age_labels) +
        geom_point() +
        geom_smooth(method = "lm", col = "red")
}
