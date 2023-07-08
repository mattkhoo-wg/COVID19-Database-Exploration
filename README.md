# COVID-19 Data Analysis Project
This repository contains a data analysis project focused on examining COVID-19 data, exploring the relationship between different varaiables and the rate of spreading in multiple countries. The project uses a Microsoft SQL database and a jupyter notebook to explore and visualise data. We utilized statistical models to predict the impact of of varaibles like availability to handwashing facilities, population, median age etc. on the spread of the virus.

## Introduction
The COVID-19 pandemic has significantly impacted the world, with the spread of the virus affecting different countries to varying degrees. This data analysis project aims to investigate the relationship between the availability of handwashing facilities and the rate of spreading in different countries. By analyzing relevant COVID-19 data and employing statistical models, we aim to gain insights into the potential impact of handwashing facilities on controlling the spread of the virus.

## Data Sources
To conduct this analysis, we utilized the following data sources:

COVID-19 Data: We obtained COVID-19 data from [OurWorldInData](https://ourworldindata.org/coronavirus). The data includes information on total cases, total tests conducted, and other relevant variables for different countries.

Please note that the data used in this project is accurate as of the knowledge cutoff date, which is September 2021. Subsequent updates to the data may not be reflected in this analysis.

## Project Structure
The project repository is structured as follows:

The main components of the project structure are as follows:

data/: This directory contains the raw data files used in the analysis. The CovidData.csv file contains COVID-19 data. CovidDeathsTrimmed.csv and CovidVaccinations.csv is cleaned and processed data for uploading to the database.

database/: This directory contains a notebook to set up and load data into a Microsoft SQL Server Database. There are also various SQL files to execute queries to pull information and stored procedures which improve database efficiency and performance.

notebooks/: This directory contains Jupyter notebooks used for data exploration and building statistical models. The DataExplorationPandas.ipynb notebook focuses on data exploration and visualization, while the statistical_models.ipynb notebook contains the implementation of statistical models.

README.md: The README file you are currently reading, providing an overview of the project and instructions for usage.

### Data Exploration
The data_exploration.ipynb notebook explores the COVID-19 and handwashing facilities data. The analysis includes:

Exploratory data analysis (EDA) of COVID-19 cases, tests, and other relevant variables.
Visualization of trends and patterns using plots, graphs, and statistical summaries.
Correlation analysis to identify potential relationships between variables.
Comparison of handwashing facility availability with COVID-19 spread in different countries.
### Statistical Models
The statistical_models.ipynb notebook focuses on building statistical models to predict the impact of handwashing facilities on the rate of spreading in different countries. The analysis includes:

Preprocessing and feature engineering steps.
Selection of appropriate statistical models (e.g., regression, machine learning algorithms).
Training and evaluation of the models.
Interpretation of model results and assessment of the relationship between handwashing facilities and COVID-19 spread.
Results
The analysis results, including the processed data and predictions from the statistical models, can be found in the results/ directory. The analysis_results.csv file contains the final data, and the figures/ subdirectory stores visualizations generated during the analysis.

Please refer to the analysis results for detailed insights into the relationship between handwashing facility availability and the rate of spreading in different countries.

License
The project is licensed under the MIT License. Feel free to use and distribute it as needed.




