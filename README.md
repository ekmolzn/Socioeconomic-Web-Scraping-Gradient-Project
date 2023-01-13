# Customer Reviews Across Socioeconomic Gradients
Why do some businesses fail?  Market research is a key element, among others, to a successful business venture in any setting.  Neglecting to gather adequate information which informs strategy may result in missed opportunities or new ventures resulting in failure.  Businesses that have learned to adapt to their host setting often boast of proven historical successes.   

  

The aim of this study is to answer the following question: Do socioeconomic factors influence customer reviews?  Perhaps wealthy backdrops contain highly critical reviews of demanding patrons.  On the contrary, it may be that poorer communities experience lower quality services that result in negative reviews. This study attempts to better understand consumer expectations based on wealth status communities. 

Group members: Nathan Zlomke, Imran Haider, Matt Rigby, Rhoda Alawiye 

## Statement of Scope 
Zip codes, or Zone Improvement Plans, were introduced in 1963 to improve the efficiency of the postal system.  “What started out as a unit of geography has become a basic unit of demography (1).”  Since its onset, the zip code has established itself as a robust metric used in marketing, legislation, census data, and more.  More recently, some communities are “self-segregating toward higher-income neighborhoods in search of better school districts, pushing up house prices in those zip codes, and leaving lower-income families behind (2).” 

Now more than ever, zip code demographics are becoming well understood and more distributed according to wealth.  Our hope is to leverage this robust metric with the ubiquitous amount of online customer reviews to provide us insights about community consumer psychology. 
 

The goal of this project is to understand consumer expectations across a wealth gradient.   

In order to draw distinctions between communities based on zip code, it is necessary to define a scope of study.  Rather than arbitrarily selecting various geographical states, it was decided to measure a US state that demonstrates adequate sample size of diverse wealth indexes, or zip codes.  California was selected as the state for analysis as it is considered the most economically and culturally diverse state (4). 

There are roughly 1,700 zip codes in California.  Demographic data will be scraped from http://www.mapszipcode.com/ and randomized sample of 500 zip codes will be used to describe the population 

Restaurants, hotels, and haircut parlors were selected as measurement groups, as rich, poor, and middle class alike frequent these types of businesses that are shaped by customer reviews.  It was apparent that sampling bias could alter the findings if careful selection of categories was not in place.  For example, coffeeshops, car washes,  or even mechanics could bias towards wealthier settings.  Some groups may not provide any meaningful insights,such as grocery store reviews.   

Statistical analysis will be performed in order to observe trends and correlations in the data 

Results will be summarized with recommendations based on insights drawn from analysis 


Zip codes are the chief unit of analysis for this study and relates to demographics as well as customer reviews.    

## Project Schedule
The project was initiated with brainstorming different ideas for scraping, ranging from oil prices to crypto, and settled on the consumer expectations across a wealth gradient--observing data at the zip code level.    

We identified the website, Mapszipcode.com, as the target for scraping, due to its selection of peripheral information such as population breakdown, family type, income distribution, and school attendance, even though some of these data points will not be included within our scope.  

For customer reviews data, Yelp.com was identified as a solid choice, being more powerful than Google reviews and provides a better platform for scraping.  Restaurant, hotel, and haircut parlor reviews will be scraped by markets through Yelp and summarized by zip code.  

The project schedule and activities are listed below in the Gantt chart along with the person(s) primarily responsible for each task. 

![Complete project schedule (subject to change)](/assets/project_schedule.png)

Although almost all the aforementioned tasks would be performed in a team, some people have more expertise in one domain than others, which is how the tasks were assigned.  Each task will have a primary owner while others will be helping as support.  

## Data Preparation
The first step was to scrape a list of California zip codes.  The following site provided a complete list 'https://zipdatamaps.com/list-of-zip-codes-in-california.php' 

![Example picture of zip selection](/assets/zip_selection.png)

Using Selenium in Python, the table was scraped using XPath selectors and compiled into a data frame.  There were over 2,500 zip codes: unique, non-unique, and PO Box.  After researching, it was determined that traditional zip codes are “non-unique” category, and these were filtered, using Pandas resulting in 1,710 rows of non-unique zip codes that were exported to a .csv file. 

Instead of processing all 1,710 zip codes, it was decided to use randomized sampling and reduce the count to 500 zip codes.   Data was sorted by the assigned randomized number and the top 500 were selected for analysis.   

#### Customer Reviews in Yelp 

Scraping customer review data in Yelp.com was conducted using a series of loops in which the outermost iterated through zip codes from the previously mentioned list.  Each zip code was spliced into unique URL in Yelp.com to yield customer review data across respective categories.   

Within this loop, another `for` loop that iterated page values in order to grab two page results per business.  This, was embedded within the URL in the same way as the zip codes. 

Following this, a `while` loop iterated through an XPath selector where the <list> element could be iterated through to grab each desired data point.  Several Selenium exception rules were required, as not every element would pull successfully every time for every business.  This resulted in a dataset integrity issue, as the rows would become mismatched.  The `NoSuchElementException` parameter within an exception protocol was discovered and utilized, and for unsuccessful XPath selection instances, "Scraping Error” was printed in that unique cell.  This allowed for a value to be produced in any case for each iteration, and the variable containers all contained equivalent row counts. 

After restaurants were scraped successfully, different teammates were able to use the script in order to pull other categories by making small adjustments.  In this way, hotels and haircut parlors were pulled. 

For each category, the following data points were scraped: business name, review score, and review count per zip code and subsequently compiled into a data frame using Pandas and exported as a .csv file. 
  
![Example of Yelp data points for scrape](/assets/yelp.png) 
 
#### Zip Code Demographics 

The next step was to perform scraping at Mapszipcode.com. 

Mapszipcode.com has a main page that allows for searching zip code and returns demographics information on the following page. As a start, it was decided to use the randomized zip codes generated to be sent as keys through selenium in the search box, search for each zip and capture the demographics information on the following page; however, this method was limited as whenever a zip was searched in the search box a dropdown menu popped up which would sometime select and search for a different (last digit different) zip code. As illustrated in picture below: 
  
![dropdown menu problen example on mapszipcode.com](/assets/zip_lookup.png) 
 
Fortunately, it was discovered that the URL followed a set pattern, and this pattern was able to be utilized and replicated in our code. The pattern of zip code is shown below:  

![URL pattern](/assets/url_pattern.png)
  
Since the state of interest was limited to California, a `For` loop that inputs city name and area name from the random zip codes .csv list referenced above and appends it to the parent URL + ‘California’. This URL directly landed on the page where the data points of interest were located.
  
![demographics data of interest](/assets/demogrpahics_to_catpure.png)
  
  
Four data points were captured: Population, Density, Median Home Value, and Median Rent using the find element method in Selenium. These data points were appended to a list which was further cleansed using the `split()` function before appending into a data frame. A creative method was utilized to speed up the scraping process, `implicitly.wait()`, available in Selenium, which allowed for data capture as soon as the web page was fully loaded rather than using `time.sleep()` method that runs the program after a fixed break regardless of the page load status.  
  
  
 #### Merging Demographic Data and Customer Review Data 

After restaurant data was pulled from Yelp.com, the zip code demographics scrape utilized the zipcode list from restaurant’s output within its looping procedure.  In doing so, each demographic value pulled in the loop would correlate to the exact row reference.  In this way, an inner join was not needed, as columns were simply appended onto the existing data frame. 

Hotels and haircut parlors would be merged using a different method in order to combine with the restaurant-demographics set.  Before doing so, various columns in each set (e.g., index column, Total Reviews), as each dataframe must have similar column conventions to be combined.  In addition to this, a ‘Category’ column was added to specify “Hotel”, “Restaurant”, or “Haircut”. 

Alas, with each dataframe yielding similar column names and order, haircut and hotels were appended.  Subsequently, duplicates were removed, which included cases of scraping errors and removing headers.  In all, there were 26,844 observations. 

### Data Access

|  | Zip Codes List | Customer Reviews | Zip Code Demographics |
|:---|:---|:---:|:---:|
| Website URL  | Zipdatamaps.com  | Yelp.com  | Mapszipcode.com  | 
| Example Link | https://zipdatamaps.com/list-of-zip-codes-in-california.php | https://www.yelp.com/search?find_desc=Hotels&find_loc=90210&sortby=review_count&start=10   | http://www.mapszipcode.com/california/beverly%20hills/90210/ |
| Description | A list of zip codes for California was collected in order to draw a random sample and input sample zip codes into Python scripts | Customer reviews data for different market categories.  This will allow us to gauge customer satisfaction and relate it to zip codes  | Demographic information listed for each zip code.  This allows for the inclusion of community metrics relative to customer reviews  | 
|Column Associated with Each Website  | `Zipcode` | `Business Name`, `Review Score`,`Total Reviews` (removed)   | `Population`,`Median_Home_Value`, `Median Rent`  | 

Each of these were scraped using Selenium in Python through Gecko Driver.

Text about data access. We scraped data from Canvas using the Firefox geckodriver, as seen here:

```Python
driver = webdriver.Firefox(executable_path=r'C:\Users\bryanih\Documents\GitHub\geckodriver.exe')
canvas_url = 'https://stwcas.okstate.edu/cas/login?service=https%3A%2F%2Fcanvas.okstate.edu%2Flogin%2Fcas'
driver.get(canvas_url)
```

### Data Cleaning
Summary functions were performed on the data to detect any outliers that needed to be removed before the data was transformed. We noticed that the minimum median home value for a zip code was $9,999 which has two issues: 1. We know from common knowledge that median home value cannot be as low as $9,999 which is confirmed by the the second smallest value for home in a zip code was $54,000 2. It is common to use 9999 as a placeholders for missing values so it made sense that this is a placeholder value rather than an actual data point, so we decided to remove observations with a home value of $9,999. 

A merged dataset is shown below.  As seen, it has extraneous columns in addition to ‘Zipcode’, ‘Review Score’, ‘Population’, ‘Median Home Value’ and 'Median Rent.’ Initially, it was thought that a primary key may be necessary, which was a concatenation of zip code and business name, but as the project went on, it was determined that this would not be necessary and was dropped.   

‘Total_Reviews’ was a desired data point, and initially, the XPath selector for this worked in testing.  However, during scraping, it seems that XPath numerical references specific to this shifted on Yelp.com and the XPath selector could not successfully pull data.  In the output file for restaurants, total records were 8,873 observations, and only 171, or 2%, of the data had a corresponding value for `Total Reviews`, too low to be used for analysis. Due to this, it was dropped from analysis.  Index columns were also removed. 

![initial data image](/assets/cleaned_data.png)

As mentioned, the scraping code contained an `Exception` clause for instances where it was not able to successfully utilize the XPath selector to pull data.  One of the limitations of the analysis that we are doing arises from these ‘scrapping errors or missing data points. Total reviews for each business establishment would have allowed for a weighted average review for the zip code. A weightage average review for the zip code would have provided a better understanding of consumer behavior as a 4.5-star review of an establishment with 10 reviews is very different from a 4.5-star review of an establishment with 500 reviews. However, during the scrapping script was unable to pick up 99% of the review count. For instance, only 72 out of 26,000 restaurants had an associated review count with them. We decided to drop the entire column of the total review count since 99% of the observations in the data didn’t have a value.  
### Data Transformation
The merged dataset had wrong datatypes for multiple columns, so the following transformation was performed to arrive at a usable dataset:

* Renamed the first blank column to index_number and converted the column from integer to string 

* Converted zip code column from integer to string 

* Regular expressions were utilized for the “Review Score” column in order to drop text strings surrounding the numerical value.  For example, if a review said, “2.5-star rating”, this was reduced to ‘2.5’ as a numerical value 

![Regex code for numerical values)](/assets/regex.png)

* Converted population column to string, then removed commas from values, and finally converting strings to number 

* Converted median home value column to string, then removed commas and dollar signs from values, and finally converting strings to number 

* Converted median rent column to string, then removed commas and dollar signs from values, and finally converting strings to number 

![Example code for cleaning data)](/assets/data_cleaning_code.png)

The final output after data cleaning and transformations looked as follows: 

![demo cleaned datafile csv)](/assets/cleaned_data.png)

### Data Reduction
Various levels of data not deemed necessary were removed from our output table.  For example, the index values, primary key, and total reviews count were removed.   

![Data reduced](/assets/data_reduction.png)

As mentioned under Statement of Scope: Objectives, data selection was limited to a sample from California, a good indicator state, as it is the most culturally and economically diverse of any US state with a large population.  Categorical data for user reviews was also limited to those industry segments whose clientele appeal to all wealth classes and provide meaningful data. 

### Data Consolidation
Numerous amounts of files were exported and imported during various stages of data preparation.  This was due in part to conducting batch runs of web scraping by 100 sample increments for all 500 zip codes.  Each category’s subparts were then imported and combined into its respective categorical dataframe through ‘concat()’ in Pandas.   

With each teammate conducting various tasks in data preparation, cleansing, and consolidation, updated .csv files were exchanged as well over Discord.  After all, three categories were merged with demographic data, they were appended into a master file containing all the data in one file. 

 
### Data Dictionary
A short description of the table below. Be sure to link each row to a data file in your directory `data` so I know where it is stored.

| Attribute Name | Description | Data Type | Source | Data | Example |
|:---|:---|:---:|:---|:---|:---:|
| `Zipcode` | PrimaryKey; Zip code value in California | str | http://www.zipdatamaps.com | [zip_with_categories_full_all.csv](data/zip_with_categories_full_all.csv) | 95364  
|`Business Name` | Name of the establishment | str | http://www.yelp.com | [zip_with_categories_full_all.csv](data/zip_with_categories_full_all.csv) | The Rock of Twain Harte 
| `Review_Score` | Review score for the business on Yelp | float | http://www.yelp.com | [zip_with_categories_full_all.csv](data/zip_with_categories_full_all.csv) | 3.7 
| `Population` | Total population of the zip code | integer | http://www.mapszipcodes.com | [zip_with_categories_full_all.csv](data/zip_with_categories_full_all.csv) | 44122 
|`Median_Home_Value` | Median value of all homes within the zip code | float | http://www.mapszipcode.com | [zip_with_categories_full_all.csv](data/zip_with_categories_full_all.csv) | 173700.00 
| `Median_Rent` | Median rent of all homes within the zip code | float | http://www.mapszipcode.com | [zip_with_categories_full_all.csv](data/zip_with_categories_full_all.csv) | 1413.00 
| `Category` | Business category for each business | str | (User-defined) | [zip_with_categories_full_all.csv](data/zip_with_categories_full_all.csv) | Hotel | All your base |


## Visualizations
### Pre-Analysis and Distributions

To begin, a population distribution was plotted in order to view the frequency of zipcodes within the dataset. There were a  total of 437 distinct zipcodes within the following visualisation. 

 <p align="center"> 
<img src=assets/zip_pop_hist.png> 
</p>
<div align="center"> Figure (i) </div>
  
  <section>
    <img width="500" height="500" src=assets/Hist_Pop.png>
    <img width="500" height="500" src=assets/Hist_Pop_above.png>
</section>

<div align="center"> Figure (ii) </div>
  
From the histogram on the left, it can be observed that it is sharply right-skewed and the lowest tier values contain a large frequency.  It was decided to remove `Population` values less than 6,500, as indicated within the red rectangle.  This is due primarily to statistical issues resulting in low sample size.  Higher `Population` samples will help ensure that data is more representative of each community and business.  
  
The histogram on the right is shown with the filter applied.  All further analysis will be conducted with this filter applied.

<p align="center"> 
<img src=assets/Hist_MedHome.png> 
</p>
<div align="center"> Figure (iii) </div>

A visual analysis of the `Median Home Value` shows that majority of the houses were priced between approximately $190,000 to 625,000. However, these prices do not follow a normal distribution, which is not surprising as data is collected across many different zipcodes, so there is opportunity for extreme variations for poorer communities to extremely wealthy ones.  For example, in California one can observe metrics in rich communities such as Beverly Hills or Silicon Valley or poor communities within LA or San Diego.  This precisely the reason California was chosen for this analysis, as it is the most culturally and economically diverse of all 50 states within the US.

<div align="center">
<img src=assets/Hist_MedRent.png>
</div>
<div align="center"> Figure (iv) </div>

Unlike `Median Home Value`, `Median Rent` values display distribution that is nearly normal, suggesting that most rental prices converge to a central tendency value despite variation seen with pricing of perhaps similar houses.  The reasons for this are outside the scope of this analysis; however, it may be reasonable to assume that the rental market has self-limiting factors that normalize the market.  For example, wealthy individuals are more likely to purchase houses than pay extremely high monthly rent.  If this is true, the general low- and middle-class can only afford up to a certain point.  Similarly, the extremely high-priced residences are less often found in a rentor's market.

Since this metric is near-normal distribution, analysis will utlize `Median Rent` as the primary predictor variable.
  
<div align="center">
<img src=assets/Hist_Rev.png>
</div>
<div align="center"> Figure (v) </div>

`Review Score` have notable peaks, usually falling on each whole number and also some within multiples of 0.5. This is understood to indicate that if reviews are given on a 5-point scale, there are times that this will round off to the whole number. More commonly, this would occur if there were less reviews for an entity, as one would begin to see more varation with more reviews.  The frequencies of each score value tend to increase consistently as the score value increases, with a left-skewed distribution.
 
<div align="center">
<img src=assets/Hist_Cat.png>
</div>
<div align="center"> Figure (vi) </div>

Of the businesses selected for analysis, hotels had the most number of reviews available followed by restaurants and haircut businesses. One possible explanation for this is the amount of thoroughput of customers for hotels and restaturants is far higher than haircut businesses. 
  
### 1.	Demographic Data Insights
#### a.	Median Home Value vs. Median Rent

<div align="center"> 
<img src=assets/1A_Home_Rent.png>
</div>
<div align="center"> Figure (vii) </div>

Median home value has a positive linear relationship with the median rent. This is expected, as one observes high or low prices in regards to home price, they would expect to find the same community also reflects high or low rental prices; they relate to one another.

The density plot shows that the rent value is normally distributed around the regression line and the relationship is homoskedastic (holds valid) even at extreme values of Median home price.  The highest concentrations were observed near the $1,000 mark for `Median Rent` and $250,000 mark for `Median Home Value`.
  
#### b.	Median Home Value vs Population

<div align="center">
<img src=assets/1B_Plot_Home_Pop.png>
</div>
<div align="center"> Figure (viii) </div>

`Median Home Value` was plotted against `Population` in orderto observe any trends.  It can be observed tha the less populus communities have higher associated Median home value.  As population increases, the median home value decreases. Although this might seem counter intutive as one often sees more populus cities commanding higher house prices, this analysis is observed on a zipcode level rather than a city level. The zip-codes with less concentration of people could be categorized as wealthier neighbourhoods with bigger house areas and self-limiting costs of living associated. 

#### c.	Median Rent vs. Population

<div align="center"> 
<img src=assets/1C_Plot_Rent_Pop.png>
</div>
<div align="center"> Figure (ix) </div>
  
`Median Rent` was plotted against `Population`. There was not a strong trend or relationship seen here. The rental values were spread out evenly along the average line, suggesting that zipcodes with more than one zipcode within the same population can have a higher or lower than average rental value. This behavior could be explained by the fact that rental price is often a function of house price and also  a function of availability (supply) and population (demand) for housing. So, population itself doesn't seem to strongly affect rental price but the complex interaction of supply and demand of properties factors in to rental prices.     

### 2.	Customer Review Trends by Demographic Data (Without Categories)
#### a.	Review Score vs. Median Rent

<section>
  <img width="500" src= assets/2A_Plot_Rev_Rent.png>
  <img width="500" src= assets/2A_Plot_Rev_Rent_Zoom.png>
</section>
 <div align="center"> Figure (x) </div>
  
The graph on the left displays `Review Score` against `Median Rent`.  There is a gradual, constant rise in review score as median rent increases.  The scatterplot gradient in the background indicates the review score gradient from red (0) to green (5).

The graph on the right is a zoomed in view of the trend line to better indicate the trend at a granular level.  Similarly, the trend line moves from about 3.75 at its origin to just below 4.0 at the higher rental markets.
  
#### b.	Review Score vs. Population
<section>
  <img width="500" src=assets/2B_Plot_Rev_Pop.png>
  <img width="500" src=assets/2B_Plot_Rev_Pop_zoom.png>
</source>
<div align="center"> Figure (xi) </div>

`Review Score` was plotted against `Population`.  As seen, this follows an opposite trend as with the previous visual.  Review score begins just under 4.0 and ends near 3.75 as population approaches 100,000.  The graph on the right shows this at a zoomed in level in order to better visualize the nature of the curve.  One may observe that in higher populations, there is greater variability with review score and the natural curve diverts from the regression line.  To better characterize this data, more data should be collected for higher populations in order to better understand the trend and lessen variability, if possible.

### 3.	Customer review trends by demographic data (with categories)
#### a.	Review Score vs. Median Rent

<div align="center"> 
<img  src=assets/3A_Plot_Rev_Rent_Cat.png>
</div>
<div align="center"> Figure (xii) </div>

The graph shows `Review Score` plotted against `Median Rent` grouped by `Category`.  Category consists of Haircut, Restaurant, and Hotel with review rankings in this respective order.  All categories, tend towards higher customer reviews as rental values increase. 

Haircut may lead as customers often have more personal connections with their barber/stylist as opposed to a broader business such as a hotel or restaurant.  This also comes with a greater sense of accountability to ones score that may result in such a reason for higher scores.  It should be mentioned that haircuts have the least amount of perceived expectations on a business:  friendly service and good haircut.  Additional explanation is offered below.

Restaurant fell below haircuts and above hotels.  This category is somewhat of a hybrid, as it often has elements of personal connection with one's waiter/waitress that can influence reviews, yet it has more of a business backdrop than haircuts do.  Restaurants have a few more perceived points that influence one's impression.  In addition to quality of service, one has perceptions of food quality, comfort, wait time, and atmosphere.  This proposed higher number of perceived measurements by the customer may be a cause for lower review scores for this market type when compared with haircuts.

The lowest rated category was hotels.  Following from the previous two categories, this provides almost no personal connection with the customer and is primarily a business interaction.  Additionally, there are numerous expectations one places upon their hotel.  The following are only a few examples:  check-in; atmosphere; service; room quality, size, cleanliness, and amenities; breakfast; wifi; pool; other guests; location; and so on.

Each of these tend to have stratified price structures that may also influence how entitled a customer feels towards the service or product.  In other words, haircuts tend to cost less than meals which cost less than hotel rooms.  With each stratification, customers may expect more for their money.

For the reasons listed above, if one is to conduct market research, it would be prudent to note the range of customer review scores by a per category basis and using the combined trend line seen in the previous section as a general trend.

#### b.	Review Score vs. Population

<div align="center">
<img src= assets/3B_Plot_Rev_Pop_Cat.png>
</div>
<div align="center"> Figure (xiii) </div>
  
Review Score` was plotted against `Population` by `Category` to observe whether a relationship occurred.  For the most part, there the trends were flat for haircuts and restaurants.  Hotels showed consistently that as one moves across a population gradient, review scores go down.  There may be many reasons for this, and this analysis does not attempt to understand this relationship, but generally speaking, customers feel that they experience a lessened quality of product as they move into higher populations.  This is fairly intuitive as higher concentrations may increase hotel price and one may have a less personalized experience.

#### c.	Bar chart of Review Score vs. Categories

<div align="center">
<img src =assets/3C_Bar_Rev_Cat.png>
</div>
<div align="center"> Figure (xiv) </div>

The last graph is a bar chart showing the average `Review Score` per `Category`.  Haircuts led with 4.35, Restaurants with 3.93, and Hotels with 3.22 average review score.

## Conclusion and Discussion

The strategy for data gathering was initially to scrape zip codes for California and form a subset of this with which to use for future analysis.  The selected subset was imported and utilized in a loop that utilized this variable in Yelp.com’s unique URL code.  Then, using XPath selectors, the desired data points were extracted and appended into dataframes using Pandas library.

The same method was used in a loop to extract the demographic data from Mapszipcode.com, only that instead of using the original zip code file as input for the loop, the output file of the previous process was imported that enabled columns to be merged without needing a join. 

Following this, visualizations were performed using ggplot2 in R.

The data generally shows that as one moves across a wealth gradient, customer review scores increase.  This seemed counterintuitive at first glance, as often with richer communities tends to come more entitlement and shrewdness.  Generalizations aside, it may be the case that quality of goods and services are likely to be higher in these areas with specialty boutique shops, high end hotels, and famously popular restaurants that command higher reviews.  It would seem that businesses that are able to exist in these higher wealth zones have impressed customers.

#### Experienced Challenges 

There were several challenges with XPath selectors on Yelp.com. Each page had sponsored businesses that match the same XPath selectors as our variables.  The sponsored content was usually from a different zipcode and was not desired for scraping.  Our XPath logic was initiated and worked in testing; however, as the project developed, the selectors seemed almost to lose their initial “potency.”  Without id tags, it became difficult to scrape the intended data.  For this reason, ‘Reviews_Count’ was omitted from analysis.
  
There was an early attempt to add ‘Review Comments’ within the loop.  This was more difficult, as it required clicking a link within each business’ review.  This was close to succeeding using XPath and actions from the Gecko Driver, yet it ran into issues with outputing data from the loop into a multiple column dataframe.  Many hours were spent on this, and it was decided to continue forward with data that was pulled successfully.  Another considerable challenge with this variable is the required time investment to extract sentiment data from comments, using regular expressions. 

If performed again, analysis would be broadened to pull more categories from demographics such as age, income, among other factors.

#### Future Implications

The hope from the analysis is to discover trends and explore relationships between demographic factors and consumer behavior for the business establishment under consideration as well as form generalizations in the wealth: user review relationship. 

This study attempted to characterize whether there is a relationship that socioeconomic factors influence customer reviews.  To requote a portion of text from above, "Perhaps wealthy backdrops contain highly critical reviews of demanding patrons.  On the contrary, it may be that poorer communities experience lower quality services that result in negative reviews."  The belief that wealthy consumers are more critical of the quality of services they receive is contrary to the results found in this analysis.  

As discussed, wealthy communities, in fact, displayed greater satisfaction in their goods and services for the haircut, restaurant, and hotel categories.  While causation for this is not within the scope of this study, one can generalize that everyone expects a certain standard for goods and services.  In poorer communities, there is less satisfaction as a consumer, but in wealthier communities, there is a greater sense of satisfaction.  

Certain markets may take this to invest more or better resources for wealthier communities, and may also work to improve quality in lower wealth gradients.


More exploratory analysis such as sentiment analysis and more granular views on wealthy or poor communities could be performed in order to better make generalizations. 


#### Links to `code` and `data`

Links to data sources listed in `data` directory may be accessed here:

* [zip_with_categories_full_all.csv](https://github.com/msis5193-pds1-2022fall/project-deliverable-1-team-zippy/blob/main/data/zip_with_categories_full_all.csv) The final dataset generated for this project

  
Links to Python code sources listed in `code` directory may be accessed here:

* [zipcode_list.py](https://github.com/msis5193-pds1-2022fall/project-deliverable-1-team-zippy/blob/main/code/zipcode_list.py) Python file used to scrape zipcodes for CA from *zipdatamaps.com*
* [yelp.py](https://github.com/msis5193-pds1-2022fall/project-deliverable-1-team-zippy/blob/main/code/yelp.py) Python file used to scrape, cleanse, transform, reduce data and output to .csv, this was the original and was for restaurants  *yelp.com*
* [yelp_hotels.py](https://github.com/msis5193-pds1-2022fall/project-deliverable-1-team-zippy/blob/main/code/yelp_hotels.py) Python file similar to previous file but customized for hotels category *yelp.com*
* [script.py](https://github.com/msis5193-pds1-2022fall/project-deliverable-1-team-zippy/blob/main/code/script.py) Python file used to scrape zipcode demographics and output to .csv  *mapszipcode.com*
* [Yelp_3categories.py](https://github.com/msis5193-pds1-2022fall/project-deliverable-1-team-zippy/blob/main/code/Yelp_3categories.py) Python file used to combine all 3 categories, cleanse, reduce data
* [cleaning_full_scrape_file.py](https://github.com/msis5193-pds1-2022fall/project-deliverable-1-team-zippy/blob/main/code/cleaning_full_scrape_file.py) Python file used to finalized cleaning .csv output file

Links to R code sources listed in `code` directory may be accessed here:
* [Histograms.R](code/Histograms.R) R file used to plot distributions of dataset using ggplot2
* [All_Graphs.R](code/All_Graphs.R) R file used to plot all other visualizations using ggplot2
* [zip_histogram.R](code/zip_histogram.R) R file used to plot population distribution counting for one population value per zipcode 

### References
1. https://guides.loc.gov/this-month-in-business-history/july/zip-code-introduced#:~:text=The%20ZIP%20in%20ZIP%20Code,the%20speed%20of%20mail%20delivery. 

2. https://www.marketwatch.com/story/americas-zip-codes-are-becoming-more-segregated-heres-how-its-probably-already-impacting-you-2019-08-13 

3. https://www.usnews.com/news/best-states/articles/2020-09-10/california-is-the-most-diverse-state-in-the-us 

4. https://www.usnews.com/news/best-states/articles/2020-09-10/california-is-the-most-diverse-state-in-the-us 
