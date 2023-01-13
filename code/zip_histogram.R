
library(ggplot2)
library(scales)
library(dplyr)
library(stringr)

zipdemo = read.csv('C:\\Users\\abrar\\Documents\\prog_vis\\zip_with_categories_full_2.csv', sep = ',', header = TRUE)
colnames(zipdemo)
#Zipcode  Business.Name Review_Score  Population  Median_Home_Value Median_Rent Category


#Population distribution couting one zipcode at a time

(population_theme=
    ggplot(zipdemo, aes(x=Population))+
    geom_histogram(bins=25, fill='gray20')+
    labs(title="Population Distribution",x="Population", y = "Number of zipcodes")+
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