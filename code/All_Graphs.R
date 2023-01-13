wd= 'C:\\Users\\Nathan\\Desktop\\MSIS'
setwd(wd) 
library(ggplot2)
library(scales)
library(dplyr)
library(stringr)

zipdemo = read.csv('zip_with_categories_full_all.csv', sep = ',', header = TRUE)

#Filtering out populations less than 6,500
zipdemo_above = zipdemo %>%
  filter(Population>=6500)

#Theme for review graphs
rev_theme = theme(plot.title = element_text(hjust = 0.5, family = 'Georgia', color = 'gray0', face = 'bold', size = 15),
                  plot.background = element_rect(fill = 'gray100'),
                  panel.background = element_rect(fill = 'gray80'),
                  axis.title = element_text(family = 'Georgia',
                                            color= 'black',
                                            size=12),
                  axis.text.x = element_text(family = 'Arial',
                                             color='black',
                                             size=10),
                  axis.text.y = element_text(family = 'Arial',
                                             color='black',
                                             size=10),
                  legend.title = element_text(family = 'Arial',
                                              color='black',
                                              size=10,
                                              face = 'bold'),
                  legend.text = element_text(
                    family = 'Arial',
                    color='black',
                    size=8),
                  legend.title.align = 0.5,
                  legend.position = c(.92,.195),
                  legend.background = element_rect(fill=alpha('gray80', 0.0),size=0.5, linetype='solid'))


#***********************************
#Metadata

#DONE
#Median Home vs. Median Rent
zipdemo_above %>%
  ggplot(aes(x=Median_Home_Value, y=Median_Rent))+
  geom_point(alpha=0.007)+
  stat_density2d(aes(fill=..level..),
                 geom = 'polygon', 
                 alpha=0.35)+
  geom_smooth(method=lm, 
              size=1.25, 
              color='black')+
  scale_fill_viridis_c(option='mako', trans = 'reverse')+
  labs(
    title="Median Home Value vs. Median Rent",
    x="Median Home Value", 
    y = "Median Rent")+
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
                               size=10),
    legend.position = 'none')+
  scale_x_continuous(labels = scales::dollar_format(), expand= c(.01,0.01))+
  scale_y_continuous(labels = scales::dollar_format(), breaks = c(750,1000,1250,1500, 1750))
  


#DONE
#Med Rent vs. Population
zipdemo_above %>%
  ggplot(aes(x=Population, y=Median_Rent))+
  geom_smooth(method=lm, color='red', size=1.25, linetype='dashed')+
  geom_line(stat='smooth', color='black', size=1.25, alpha=0.6)+
  geom_point(alpha=0.07, aes(color =Median_Home_Value))+
  labs(title="Median Rent vs. Population",x="Population", y = "Median Rent")+
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
                               size=10),
    legend.position = 'none')+
  scale_x_continuous(labels = comma, expand= c(.01,0.01), breaks = c(25000,50000,75000,100000))+
  scale_color_gradient(low='olivedrab2',high='darkgreen')+
  scale_y_continuous(labels = scales::dollar_format(), breaks = c(750,1000,1250,1500,1750))




#DONE
#Med Home vs. Population
zipdemo_above %>%
  ggplot(aes(x=Population, y=Median_Home_Value))+
  geom_smooth(method=lm, color='red', size=1.25, linetype='dashed')+
  geom_line(stat='smooth', color='black', size=1.25, alpha=0.6)+
  geom_point(alpha=0.07, aes(color =Median_Home_Value))+
  labs(title="Median Home Value vs. Population",x="Population", y = "Median Home Value")+
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
                               size=10),
    legend.position = 'none')+
  scale_x_continuous(labels = comma, expand= c(.01,0.01))+
  scale_color_gradient(low='olivedrab2',high='darkgreen')+
  scale_y_continuous(labels = scales::dollar_format())





#**********************************
#DONE
#Review Score vs. Population
zipdemo_above %>%
ggplot(aes(x=Population, y=Review_Score))+
  geom_smooth(method=lm, color='red', size=1.25, linetype='dashed')+
  geom_line(stat='smooth', color='black', size=1.25, alpha=0.6)+
  ylim(1,5)+
  geom_point(alpha=0.07, aes(color =Review_Score))+
  labs(
    title="Review Score vs. Population",
    x="Population", 
    y = "Review Score")+
  rev_theme+
  scale_x_continuous(labels = comma, expand= c(.01,0.01))+
  scale_color_gradient2(low='red3',mid = 'yellow',high='chartreuse4', midpoint=3, 'Review\nScore')


#DONE
#Review Score vs. Med Rent
zipdemo_above %>%
  ggplot(aes(x=Median_Rent, y=Review_Score))+
  geom_smooth(method=lm, color='red', size=1.25, linetype='dashed')+
  geom_line(stat='smooth', color='black', size=1.25, alpha=0.6)+
  ylim(1,5)+
  geom_point(alpha=0.07, aes(color =Review_Score))+
  labs(title="Review Score vs. Median Rent",
       x="Median Rent", 
       y = "Review Score")+
  rev_theme+
  scale_x_continuous(limits = c(500,2000),
                     labels = scales::dollar_format(), 
                     expand= c(-.02,0.01),
                     breaks = c(500, 750,1000,1250,1500,1750,2000))+
  scale_color_gradient2("Review\nScore",low='red3',mid = 'yellow',high='chartreuse4', midpoint=3)

zipdemo_above %>%
  ggplot(aes(x=Median_Rent, y=Review_Score))+
  geom_smooth(method=lm, color='red', size=1.25, linetype='dashed')+
  geom_line(stat='smooth', color='black', size=1.25, alpha=0.6)+
  lims(x=c(500,2000),y=c(3,4.5))+
  labs(
    title="Review Score vs. Median Rent",
    x="Median Rent", 
    y = "Review Score"
  )+
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
  scale_x_continuous(breaks = c(500,750,1000,1250,1500,1750,2000),
                     labels = scales::dollar_format(), 
                     expand= c(-.02,0.01))


zipdemo_above %>%
  ggplot(aes(x=Population, y=Review_Score))+
  geom_smooth(method=lm, color='red', size=1.25, linetype='dashed')+
  geom_line(stat='smooth', color='black', size=1.25, alpha=0.6)+
  labs(
    title="Review Score vs. Population",
    x="Population", 
    y = "Review Score"
  )+
  rev_theme+
  scale_x_continuous(expand= c(-.02,0.01), labels = comma)+
  ylim(2,5)


zipdemo_above %>%
  ggplot(aes(x=Population, y=Review_Score))+
  geom_smooth(method=lm, color='red', size=1.25, linetype='dashed')+
  geom_line(stat='smooth', color='black', size=1.25, alpha=0.6)+
  labs(
    title="Review Score vs. Population",
    x="Population", 
    y = "Review Score"
  )+
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
  scale_x_continuous(expand= c(-.02,0.01), labels = comma)

#********************************************************************
#********************************************************************
#*Part 3 - Categorized
#********************************************************************


#Review Score vs. Population
zipdemo_above %>%
  ggplot(aes(x=Population, y=Review_Score, group=Category, color = Category))+
  geom_smooth()+
  labs(title="Review Score vs. Population",
       x="Population", 
       y = "Review Score")+
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
                               size=10),
    legend.position = 'none'
  )+
  scale_x_continuous(limits = c(6500,100000), labels = comma, expand= c(-.02,0.01))+
  annotate("label", x=56000, y=4.16,  size=3, color = 'red3', fontface='bold',
           label = glue::glue("Haircut"))+
  annotate("label", x=56000, y=4.01,  size=3, color = 'steelblue4', fontface = 'bold',
           label = glue::glue("Restaurant"))+
  annotate("label", x=56000, y=3.48,  size=3, color = 'seagreen4', fontface = 'bold',
           label = glue::glue("Hotel"))+
  scale_y_continuous(limits = c(2.5,4.5), expand= c(-.02,0.01))
  


#Review Score vs. Med Rent
zipdemo_above %>%
  ggplot(aes(x=Median_Rent, y=Review_Score, group=Category, color = Category))+
  geom_smooth(se=F)+geom_smooth(color = 'gray50',method=glm, linetype = 'dashed')+
  labs(title="Review Score vs. Median Rent",
       x="Median Rent", 
       y = "Review Score")+
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
                               size=10),
    legend.position = 'none'
  )+
  scale_x_continuous( labels = scales::dollar_format(), expand= c(-.02,0), breaks = c(750,1000,1250,1500,1750))+
  annotate("label", x=1250, y=4.47,  size=3, color = 'red3', fontface='bold',
           label = glue::glue("Haircut"))+
  annotate("label", x=1250, y=4.03,  size=3, color = 'steelblue4', fontface = 'bold',
           label = glue::glue("Restaurant"))+
  annotate("label", x=1250, y=3.36,  size=3, color = 'seagreen4', fontface = 'bold',
           label = glue::glue("Hotel"))+
  scale_y_continuous( expand= c(0.02,0.01))
  
#Review Score vs. Category Bar Chart
zipdemo_above %>%
  ggplot(y=Review_Score, aes(x=Category, fill = Category))+
  geom_bar()

zipdemo_above %>%
  group_by(Category) %>%
  summarise(AVG=mean(Review_Score))
# Category     AVG
#1 Haircut     4.35
#2 Hotel       3.22
#3 Restaurant  3.93

  
zipdemo_above %>%
ggplot(aes(x = reorder(Category, -Review_Score), y=Review_Score, fill = Category)) +
  geom_bar(stat = "summary", fun='mean')+
  labs(
    title="Review Score vs. Category",
    y = "Review Score"
  )+
  theme(
    plot.title = element_text(hjust = 0.5, family = "Georgia", color = 'gray0', face = "bold", size = 15),
    plot.background = element_rect(fill = "gray100"),
    panel.background = element_rect(fill = "gray80"),
    axis.title = element_text(family = 'Georgia',
                              color= 'black',
                              size=12),
    axis.text.y = element_text(family = 'Arial',
                               color='black',
                               size=10),
    legend.position = 'none',
    axis.text.x=element_blank(),
    axis.title.x=element_blank()
  )+
  ylim(0,5)+
  annotate("text",x='Haircut', y=4.48, fontface='bold',
           label = glue::glue("4.35"), size=5.5)+
  annotate("text",x='Hotel', y=3.35, size=5.5, fontface='bold',
           label = glue::glue("3.22"))+
  annotate("text",x='Restaurant', y=4.05, size=5.5, fontface='bold',
           label = glue::glue("3.93"))+
  annotate("text",x='Haircut', y=1.77, fontface='bold', color = 'white',
           label = glue::glue("HAIRCUT"), size=15, angle=90)+
  annotate("text",x='Hotel', y=1.47, size=15, color='white',fontface='bold', angle=90,
           label = glue::glue("HOTEL"))+
  annotate("text",x='Restaurant', y=2.02, size=12, angle=90, fontface='bold', color = 'white',
           label = glue::glue("RESTAURANT"))+
  scale_y_continuous(expand = expansion(mult = c(0, 0.12)))

                     