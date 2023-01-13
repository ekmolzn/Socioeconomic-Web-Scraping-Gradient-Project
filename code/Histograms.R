wd= 'C:\\Users\\Nathan\\Desktop\\MSIS'
setwd(wd) 
library(ggplot2)
library(scales)
library(dplyr)
library(stringr)

zipdemo = read.csv('zip_with_categories_full_all.csv', sep = ',', header = TRUE)

colnames(zipdemo)
#Zipcode  Business.Name Review_Score  Population  Median_Home_Value Median_Rent Category


#Population distribution
(population_theme=
    ggplot(zipdemo, aes(x=Population))+
  geom_histogram(bins=25, fill='gray20')+
  labs(title="Population Distribution",x="Population", y = "Count")+
  theme(
    plot.title = element_text(hjust = 0.5, family = "Georgia", color = 'gray0', face = "bold", size = 15),
    plot.background = element_rect(fill = "gray100"),
    panel.background = element_rect(fill = "gray80"),
    axis.title = element_text(family = 'Georgia',
                              color= 'black',
                              size=12),
    axis.text.x = element_text(family = 'Arial',
                               color='black',
                               size=10),
    axis.text.y = element_text(family = 'Arial',
                               color='black',
                               size=10))+
  scale_x_continuous(labels = comma)+
  scale_y_continuous(labels = comma)+
  geom_rect(zipdemo, mapping=aes(xmin=-2400, xmax=6500, ymin=0, ymax=3700), linetype = 'dashed', alpha=0, color ="red", size = 1.25)+
  annotate("label", x=28000,y=2750, size=3.5, color = 'gray10', fill = 'white', face = 'bold', family = 'Georgia',
           label = glue::glue('Population < 6,500 to be \nomitted from analysis'))
)

#Filtering out populations less than 6,500
zipdemo_above = zipdemo %>%
  filter(Population>=6500)

#Population with filtering applied
(pop_above_theme=
    ggplot(zipdemo_above, aes(x=Population))+
    geom_histogram(bins=25, fill='gray20')+
    labs(title="Population Distribution",x="Population", y = "Count")+
    theme(
      plot.title = element_text(hjust = 0.5, family = "Georgia", color = 'gray0', face = "bold", size = 15),
      plot.background = element_rect(fill = "gray100"),
      panel.background = element_rect(fill = "gray80"),
      axis.title = element_text(family = 'Georgia',
                                color= 'black',
                                size=12),
      axis.text.x = element_text(family = 'Arial',
                                 color='black',
                                 size=10),
      axis.text.y = element_text(family = 'Arial',
                                 color='black',
                                 size=10))+
    scale_x_continuous(labels = comma)+
    scale_y_continuous(labels = comma)
)



#review score distribution
(review_theme=
    ggplot(zipdemo_above, aes(x=Review_Score))+
    geom_histogram(bins=25, fill='gray20')+
    labs(title="Review Score Distribution",x="Review Score", y = "Count")+
    theme(
      plot.title = element_text(hjust = 0.5, family = "Georgia", color = 'gray0', face = "bold", size = 15),
      plot.background = element_rect(fill = "gray100"),
      panel.background = element_rect(fill = "gray80"),
      axis.title = element_text(family = 'Georgia',
                                color= 'black',
                                size=12),
      axis.text.x = element_text(family = 'Arial',
                                 color='black',
                                 size=10),
      axis.text.y = element_text(family = 'Arial',
                                 color='black',
                                 size=10))+
    scale_x_continuous(labels = comma)+
    scale_y_continuous(labels = comma)
)

#Median Home Value distribution
(medhome_theme=
    ggplot(zipdemo_above, aes(x=Median_Home_Value))+
    geom_histogram(bins=25, fill='gray20')+
    labs(title="Median Home Value Distribution",x="Median Home Value", y = "Count")+
    theme(
      plot.title = element_text(hjust = 0.5, family = "Georgia", color = 'gray0', face = "bold", size = 15),
      plot.background = element_rect(fill = "gray100"),
      panel.background = element_rect(fill = "gray80"),
      axis.title = element_text(family = 'Georgia',
                                color= 'black',
                                size=12),
      axis.text.x = element_text(family = 'Arial',
                                 color='black',
                                 size=10),
      axis.text.y = element_text(family = 'Arial',
                                 color='black',
                                 size=10))+
    scale_x_continuous(labels = comma)+
    scale_y_continuous(labels = comma)
)

#Median Rent distribution
(medrent_theme=
    ggplot(zipdemo_above, aes(x=Median_Rent))+
    geom_histogram(bins=25, fill='gray20')+
    labs(title="Median Rent Distribution",x="Median Rent", y = "Count")+
    theme(
      plot.title = element_text(hjust = 0.5, family = "Georgia", color = 'gray0', face = "bold", size = 15),
      plot.background = element_rect(fill = "gray100"),
      panel.background = element_rect(fill = "gray80"),
      axis.title = element_text(family = 'Georgia',
                                color= 'black',
                                size=12),
      axis.text.x = element_text(family = 'Arial',
                                 color='black',
                                 size=10),
      axis.text.y = element_text(family = 'Arial',
                                 color='black',
                                 size=10))+
    scale_x_continuous(labels = comma)+
    scale_y_continuous(labels = comma)
)

#Category distribution
(categ_theme=
    ggplot(zipdemo_above, aes(x=Category))+
    geom_bar(fill='gray20')+
    labs(title="Category Distribution",x="Category", y = "Count")+
    theme(
      plot.title = element_text(hjust = 0.5, family = "Georgia", color = 'gray0', face = "bold", size = 15),
      plot.background = element_rect(fill = "gray100"),
      panel.background = element_rect(fill = "gray80"),
      axis.title = element_text(family = 'Georgia',
                                color= 'black',
                                size=12),
      axis.text.x = element_text(family = 'Arial',
                                 color='black',
                                 size=10),
      axis.text.y = element_text(family = 'Arial',
                                 color='black',
                                 size=10))+
    scale_y_continuous(labels = comma)
)  

