# Understanding Effects of Demographic and Socio-Economic Factors on Rate of Drug Overdose Deaths in the US 

## Introduction
Collectively alcohol, marijuana and illicit drug usage accounts for 11.8 million1 deaths each year globally. Opioid
overdoses are by far the most common in the United States with death rates in the US several times higher than in
other developed nations such as Canada, Russia and others. The NIH’s National Institute of Drug Abuse estimated that
nearly 92,0002 people died due to drug overdoses in the United States in 2020 alone with a 30% increase from the
previous year.<br>
The opioid crisis in the United States has affected rural and urban populations alike, but its effect has been
most acute in poorer, more marginalized communities where access to healthcare remains poor. Studies indicate that in
addition to individual risk factors (history of psychiatric disorders and genetic factors) broader environmental risk
factors such as governmental policies, socio-economic and socio-spatial inequalities influence substance use disorders.
Through this project, we will be examining county-level and state-level illicit drug overdose determinants and
their variation across chosen areas of study. By understanding the effect of demographic and socio-economic factors
on prevalence of drug overdose deaths, we will be able to identify strong predictors for explaining variations in drug
overdose deaths across different US states and counties. Through this, we hope to achieve a better understanding of
how environmental risk factors affect drug overdoses and which can be used to develop targeted interventions through
policies and community work.<br>

## Methodology
We aim to study potential effects of various factors on the rate and number of drug related overdose deaths ( ) by
regressing the overdose rate onto demographic and socio-economic factors ( ) for the year 2020 by state and
county-level in the US indexed by in the above equation. Such factors may include
➢ Median household income
➢ Percent of insured people
➢ Poverty rate
➢ Level of education
➢ Race of sample population
➢ Ethnicity of sample population
➢ Inequality in household income
➢ Unemployment rate
➢ Disability rate
As part of our initial data exploration, we will estimate the probability distribution of continuous factors using Kernel
Density Estimation to verify a Normal distribution. If necessary, we might choose to transform certain variables to
achieve a Normal distribution. Further, we will perform correlation analysis and data visualization to understand the
relationship between our variables to reduce the risk of multicollinearity, where highly correlated variables can reduce
the accuracy of our regression model.
We suspect that outliers may decrease the overall accuracy of a standard OLS regression model. Therefore, we
aim to introduce regularization into our model to limit the effect of any singular factor on the prediction, such models
may include Lasso (L1) and Ridge (L2) regression.
Lastly, we aim to employ Bayesian inference models such as Bayesian Linear Regression to compare accuracy
between regression models.
