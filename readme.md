immdonor
================

``` r
panels<- tcell %>% group_by(panel_id,parameters)  %>% count(marker_id)
samples<-  tcell %>% group_by(biosampleType) %>% count(biosampleType)
```

    ## # A tibble: 11 x 2
    ## # Groups:   biosampleType [11]
    ##    biosampleType             n
    ##    <chr>                 <int>
    ##  1 Colon                    59
    ##  2 Ileum                    61
    ##  3 Inguinal lymph node      61
    ##  4 Jejunum                  58
    ##  5 Lung                     69
    ##  6 Lung lymph node          81
    ##  7 Mesenteric lymph node    74
    ##  8 PBMC                     46
    ##  9 Spleen                   90
    ## 10 Thymus                   29
    ## 11 Whole blood              31
