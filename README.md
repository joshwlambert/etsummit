
<!-- README.md is generated from README.Rmd. Please edit that file -->

# etsummit

<!-- badges: start -->
<!-- badges: end -->

The goal of etsummit is to ease collaboration in our team.

## Installation

You can install the development version of etsummit from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("joshwlambert/etsummit")
```

## Our pipeline

We propose the following pipeline to tackle this issue:

1.  Explore the 2 datasets and try to understand them

2.  Perform some cleaning and standardisation to get the 2 datasets at
    the same scale

3.  Peform some descriptive statistics

4.  Find variables or combination of variables that can be associated
    with the real dengue incidence using:

    - direct correlations
    - regression
    - PCA analysis
