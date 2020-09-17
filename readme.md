immdonor
================

Immdonor is a [GraphQL API](https://graphql.org/) of
[Immport](https://www.immport.org/) Organ Donor metadata hosted on
[Hasura Cloud](https://hasura.io/). This API lets you request exactly
what data you need from the [Immport data
model](https://www.immport.org/shared/dataModel) and returns a JSON
output which can be converted to a R dataframe\!

🔥This is a fast way to link [Flow Cytometry Standard
(.FCS)](https://en.wikipedia.org/wiki/Flow_Cytometry_Standard) files to
their metadata and enables more robust analysis with
[Cytoverse](https://cytoverse.org/). You will need to have the FCS files
saved locally (see quick\_fetch.R).

## Connect to API

You can connect using your preferred GraphQL R client. Here we use
[rOpenSci’s ghql package](https://github.com/ropensci/ghql)

``` r
library(ghql)

#By connecting to this API you agree to the Immport.org Terms of Service
con <- GraphqlClient$new(url = "https://resolved-lab-57.hasura.app/v1/graphql")
```

-----

#### GET

``` r
qry <- Query$new()

studies<- qry$query('studies','{
  shared_data_study {
    study_accession
    actual_enrollment
    minimum_age
    maximum_age
  }
}')
x <- con$exec(qry$queries$studies)
```

#### ANSWER

``` r
studies<- as.data.frame (jsonlite::fromJSON(x))
```

<table>

<thead>

<tr>

<th style="text-align:left;">

study\_accession

</th>

<th style="text-align:right;">

actual\_enrollment

</th>

<th style="text-align:left;">

minimum\_age

</th>

<th style="text-align:left;">

maximum\_age

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

SDY702

</td>

<td style="text-align:right;">

56

</td>

<td style="text-align:left;">

3.00

</td>

<td style="text-align:left;">

73.00

</td>

</tr>

<tr>

<td style="text-align:left;">

SDY1041

</td>

<td style="text-align:right;">

20

</td>

<td style="text-align:left;">

21.00

</td>

<td style="text-align:left;">

70.00

</td>

</tr>

<tr>

<td style="text-align:left;">

SDY1097

</td>

<td style="text-align:right;">

43

</td>

<td style="text-align:left;">

.20

</td>

<td style="text-align:left;">

63.00

</td>

</tr>

<tr>

<td style="text-align:left;">

SDY1389

</td>

<td style="text-align:right;">

51

</td>

<td style="text-align:left;">

9.00

</td>

<td style="text-align:left;">

76.00

</td>

</tr>

</tbody>

</table>

-----

## Organ Donor Metadata

The studies listed above feature cytometry data generously donated by
organ donors. We can build queries to return exactly what metadata we
would like to know about these organ donors.

``` r
qry <- Query$new()

files<- qry$query('files','{
  resultFiles {
    filePath
    studyAccession
    subjectAccession
    maxSubjectAge
    gender
    biosampleType
    parameters
    panel_id
    markers
    
  }
}')

x <- con$exec(qry$queries$files)
files<- as.data.frame (jsonlite::fromJSON(x))
```

### Biosample types

<table class="kable_wrapper">

<tbody>

<tr>

<td>

<table>

<thead>

<tr>

<th style="text-align:left;">

Primary Lymphoid Organs

</th>

<th style="text-align:right;">

Count

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

Bone Marrow

</td>

<td style="text-align:right;">

150

</td>

</tr>

<tr>

<td style="text-align:left;">

Thymus

</td>

<td style="text-align:right;">

31

</td>

</tr>

</tbody>

</table>

</td>

<td>

<table>

<thead>

<tr>

<th style="text-align:left;">

Secondary Lymphoid Organs

</th>

<th style="text-align:right;">

Count

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

Inguinal lymph node

</td>

<td style="text-align:right;">

102

</td>

</tr>

<tr>

<td style="text-align:left;">

Lung lymph node

</td>

<td style="text-align:right;">

246

</td>

</tr>

<tr>

<td style="text-align:left;">

Mesenteric lymph node

</td>

<td style="text-align:right;">

120

</td>

</tr>

<tr>

<td style="text-align:left;">

Spleen

</td>

<td style="text-align:right;">

182

</td>

</tr>

<tr>

<td style="text-align:left;">

Tonsil

</td>

<td style="text-align:right;">

12

</td>

</tr>

</tbody>

</table>

</td>

<td>

<table>

<thead>

<tr>

<th style="text-align:left;">

Mucosal

</th>

<th style="text-align:right;">

Count

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

Colon

</td>

<td style="text-align:right;">

76

</td>

</tr>

<tr>

<td style="text-align:left;">

Ileum

</td>

<td style="text-align:right;">

61

</td>

</tr>

<tr>

<td style="text-align:left;">

Jejunum

</td>

<td style="text-align:right;">

58

</td>

</tr>

<tr>

<td style="text-align:left;">

Lung

</td>

<td style="text-align:right;">

130

</td>

</tr>

<tr>

<td style="text-align:left;">

PBMC

</td>

<td style="text-align:right;">

136

</td>

</tr>

<tr>

<td style="text-align:left;">

Whole blood

</td>

<td style="text-align:right;">

31

</td>

</tr>

</tbody>

</table>

</td>

</tr>

</tbody>

</table>

### Panels

Here are the top 5 staining panels with the most biosamples

<table>

<thead>

<tr>

<th style="text-align:left;">

panel\_id

</th>

<th style="text-align:right;">

parameters

</th>

<th style="text-align:left;">

markers

</th>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

FCM-19

</td>

<td style="text-align:right;">

14

</td>

<td style="text-align:left;">

FITC-A-CD25|Qdot 605-A-CD45RA|Qdot 655-A-CD3|QDot
705-A-CD127|APC-A-CD19|PE-Cy7-A-CD4|PE-A-FOXP3

</td>

<td style="text-align:right;">

81

</td>

</tr>

<tr>

<td style="text-align:left;">

FCM-56

</td>

<td style="text-align:right;">

20

</td>

<td style="text-align:left;">

APC-A-CMV|BV570-A-CD3|Qdot 655-A-CD4|Qdot 605 UV-A-CD8|Qdot
605-A-CD45RA|Alexa Fluor 488-A-CCR7|QDot 705-A-NA|BV421-A-CD95|Alexa
Fluor 700-A-INFg|PerCP-Cy5-5-A-TNFa|PE-Cy7-A-IL2|PE-A-CD107a|DAPI-A-DEAD

</td>

<td style="text-align:right;">

78

</td>

</tr>

<tr>

<td style="text-align:left;">

FCM-21

</td>

<td style="text-align:right;">

18

</td>

<td style="text-align:left;">

FITC-A-CD25|PE-Cy5-A-CTLA-4|BV421-A-CD69|Qdot 605-A-CD45RA|Qdot
655-A-CD3|QDot 705-A-CD127|APC-A-CD103|Alexa Fluor
700-A-KI67|APC-Cy7-A-CD8|PE-Cy7-A-CD4|PE-A-FOX-p3

</td>

<td style="text-align:right;">

57

</td>

</tr>

<tr>

<td style="text-align:left;">

FCM-1

</td>

<td style="text-align:right;">

14

</td>

<td style="text-align:left;">

Alexa Fluor 488-A-CCR7|PerCP-Cy5-5-A-CD45RO|BV421-A-CD69|Qdot
605-A-CD45RA|Qdot 655-A-CD3|QDot
705-A-CD127|APC-A-CD31|APC-Cy7-A-CD8|PE-Texas
Red-A-CD19|PE-Cy7-A-CD4|PE-A-CD28

</td>

<td style="text-align:right;">

54

</td>

</tr>

<tr>

<td style="text-align:left;">

FCM-2

</td>

<td style="text-align:right;">

18

</td>

<td style="text-align:left;">

Alexa Fluor 488-A-CCR7|PerCP-Cy5-5-A-CD45RO|BV421-A-CD69|Qdot
605-A-CD45RA|Qdot 655-A-CD3|QDot 705-A-CD127|APC-A-CD31|APC-Cy7-A-CD8|PE
Alexa Fluor 610-A-CD19|PE-Cy7-A-CD4|PE-A-CD28

</td>

<td style="text-align:right;">

52

</td>

</tr>

</tbody>

</table>

-----

## T Cell Surface Panel Analysis

<table>

<thead>

<tr>

<th style="text-align:left;">

panel\_id

</th>

<th style="text-align:right;">

parameters

</th>

<th style="text-align:left;">

markers

</th>

<th style="text-align:right;">

n

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

FCM-2

</td>

<td style="text-align:right;">

18

</td>

<td style="text-align:left;">

Alexa Fluor 488-A-CCR7|PerCP-Cy5-5-A-CD45RO|BV421-A-CD69|Qdot
605-A-CD45RA|Qdot 655-A-CD3|QDot 705-A-CD127|APC-A-CD31|APC-Cy7-A-CD8|PE
Alexa Fluor 610-A-CD19|PE-Cy7-A-CD4|PE-A-CD28

</td>

<td style="text-align:right;">

52

</td>

</tr>

<tr>

<td style="text-align:left;">

FCM-3

</td>

<td style="text-align:right;">

18

</td>

<td style="text-align:left;">

Alexa Fluor 488-A-NA|PerCP-Cy5-5-A-NA|BV421-A-NA|Qdot 605-A-NA|Qdot
655-A-NA|QDot 705-A-NA|APC-A-NA|APC-Cy7-A-NA|PE Alexa Fluor
610-A-NA|PE-Cy7-A-NA|PE-A-NA

</td>

<td style="text-align:right;">

27

</td>

</tr>

</tbody>

</table>

#### Link cytoset to metadata

In order to use all of OpenCyto’s features like `collapseDataForGating`
we need to annotate the donor metadata into the cytoset’s pData.

``` r
# Load cytoset 
fcs<- files %>% filter(data.resultFiles.panel_id == "FCM-2"|data.resultFiles.panel_id == "FCM-3")
fn<- fcs$data.resultFiles.filePath
cs<- load_cytoset_from_fcs(files = fn)

#Annotate immdonor metadata to pData
p<- pData(cs)
m<- cbind(p,fcs)
pData(cs)<- m

# Harmonize marker names
channels <- colnames(cs)
markers <- as.vector(pData(parameters(cs[[1]]))$desc)
names(markers)<- channels
markernames(cs) <- markers
```

#### Compensate and Transform

``` r
# Apply file internal compensation
comps <- lapply(cs, function(cf) spillover(cf)$SPILL)
cs_comp <- compensate(cs, comps)

# Transform fluorescent channels with FCSTrans
channels_to_exclude <- c(grep(colnames(cs), pattern="FSC"),
                         grep(colnames(cs), pattern="SSC"),
                         grep(colnames(cs), pattern="Time"))
chnls <- colnames(cs)[-channels_to_exclude]

fcstrans<- FCSTransTransform(transformationId = "defaultFCSTransTransform", channelrange = 2^18, channeldecade = 4.5, range = 4096, cutoff = -111, w = 0.5, rescale = TRUE)
transList <- transformList(chnls, fcstrans)

cs_trans<- transform(cs_comp,transList)

cs<- save_cytoset(cs_trans, "cytosets/tcell)
```

#### Build Autogating strategy

Since we annotated the cytoset with each file’s age, gender and
biosample type we can use the `collapseDataForGating` feature and
`groupby` biosampleType to improve our autogating.

``` r
cs<- load_cytoset(path = "cytosets/tcell")
gs<- GatingSet(cs)

gs_add_gating_method(gs, alias = "nonDebris",
                     pop = "+",
                     parent = "root",
                     dims = "FSC-A",
                     gating_method = "mindensity",
                     gating_args = "min = 20000, max=50000",
                     collapseDataForGating = "TRUE",
                     groupBy = "data.resultFiles.biosampleType") 
## ...
## Warning in .gating_gtMethod(x, y, ...): NAs introduced by coercion
## done

gs_add_gating_method(gs, alias = "singlets",
                     pop = "+",
                     parent = "nonDebris",
                     dims = "FSC-A,FSC-H",
                     gating_method = "singletGate")
## ...
## done


gs_add_gating_method(gs, alias = "bcells",
                     pop = "+/-",
                     parent = "singlets",
                     dims = "CD19",
                     gating_method = "mindensity",
                     collapseDataForGating = "TRUE",
                     groupBy = "data.resultFiles.biosampleType")
## ...
## Warning in .gating_gtMethod(x, y, ...): NAs introduced by coercion
## done

gs_add_gating_method(gs, alias = "CD4",
                     pop = "+/-+/-",
                     parent = "CD19-",
                     dims = "CD3,CD4",
                     gating_method = "mindensity",
                     gating_args = "min = 1500, max=2500",
                     collapseDataForGating = "TRUE",
                     groupBy = "data.resultFiles.biosampleType")
## ...
## Warning in .gating_gtMethod(x, y, ...): NAs introduced by coercion

## Warning in .gating_gtMethod(x, y, ...): NAs introduced by coercion
## done

gs_add_gating_method(gs, alias = "Tmem",
                     pop = "+/-+/-",
                     parent = "CD4+",
                     dims = "CCR7,CD45RA",
                     gating_method = "mindensity",
                     gating_args = "min = 1750, max=2500",
                     collapseDataForGating = "TRUE",
                     groupBy = "data.resultFiles.biosampleType")
## ...
## Warning in .gating_gtMethod(x, y, ...): NAs introduced by coercion

## Warning in .gating_gtMethod(x, y, ...): NAs introduced by coercion
## done


lln<- subset(gs, data.resultFiles.biosampleType == "Lung lymph node")
lung<- subset(gs, data.resultFiles.biosampleType == "Lung")
spleen<- subset(gs, data.resultFiles.biosampleType == "Spleen")
blood<- subset(gs, data.resultFiles.biosampleType == "Whole blood")
```

### CD3+CD4 T cells

Lung Lymph node

``` r
ggcyto(lln, aes(x = "CD4", y = "CD3")) + geom_gate("CD4+") + geom_hex(bins = 128)+ ggcyto_par_set(limits = "instrument")
## Coordinate system already present. Adding new coordinate system, which will replace the existing one.
```

![](readme_files/figure-gfm/unnamed-chunk-12-1.png)<!-- -->

Lung

``` r
ggcyto(lung, aes(x = "CD4", y = "CD3")) + geom_gate("CD4+") + geom_hex(bins = 128)+ ggcyto_par_set(limits = "instrument")
## Coordinate system already present. Adding new coordinate system, which will replace the existing one.
```

![](readme_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

Spleen

``` r
ggcyto(spleen, aes(x = "CD4", y = "CD3")) + geom_gate("CD4+") + geom_hex(bins = 128)+ ggcyto_par_set(limits = "instrument")
## Coordinate system already present. Adding new coordinate system, which will replace the existing one.
```

![](readme_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->

### CD4 memory subsets

![](SDY702/tmem.jpg)

Lung Lymph Node

``` r
ggcyto(gs_pop_get_data(lln ,"CD4+"), aes(x = "CCR7", y = "CD45RA")) + geom_hex(bins = 128)
```

![](readme_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->

Lung

``` r
ggcyto(gs_pop_get_data(lung ,"CD4+"), aes(x = "CCR7", y = "CD45RA")) + geom_hex(bins = 128)
```

![](readme_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

Spleen

``` r
ggcyto(gs_pop_get_data(spleen ,"CD4+"), aes(x = "CCR7", y = "CD45RA")) + geom_hex(bins = 128)
```

![](readme_files/figure-gfm/unnamed-chunk-17-1.png)<!-- -->

-----

## Metacyto analysis

work in progress…

``` r
fcs<- files %>% filter(data.resultFiles.panel_id == "FCM-2"|data.resultFiles.panel_id == "FCM-3")

fcs<- fcs %>%
  dplyr::filter(data.resultFiles.biosampleType == "Lung lymph node"|data.resultFiles.biosampleType == "Lung"|data.resultFiles.biosampleType == "Spleen"|data.resultFiles.biosampleType == "PBMC"|data.resultFiles.biosampleType == "Whole blood"|data.resultFiles.biosampleType == "Inguinal lymph node"|data.resultFiles.biosampleType == "Colon"|data.resultFiles.biosampleType == "Ileum"|data.resultFiles.biosampleType == "Jejunum")

fcs$fcs_files<- fcs$data.resultFiles.filePath
fcs$study_id <- fcs$data.resultFiles.biosampleType

fcs_info<- fcs %>% 
  dplyr::select(fcs_files, study_id)

sample_info <- fcs %>%
  dplyr::select(fcs_files, data.resultFiles.maxSubjectAge,data.resultFiles.biosampleType, data.resultFiles.gender)

preprocessing.batch(inputMeta = fcs_info,
                    assay = "FCM",
                    outpath = "metacyto/panel/preprocess_output",
                    b = 1/150,
                    excludeTransformParameters=c("FSC-A","FSC-W","FSC-H","SSC-A","SSC-W","SSC-H","Time"))
## Study ID =  Colon  Preprocessing 
## Study ID =  Ileum  Preprocessing 
## Study ID =  Jejunum  Preprocessing 
## Study ID =  Whole blood  Preprocessing 
## Study ID =  Lung lymph node  Preprocessing 
## Study ID =  Inguinal lymph node  Preprocessing 
## Study ID =  Lung  Preprocessing 
## Study ID =  Spleen  Preprocessing 
## Study ID =  PBMC  Preprocessing 
## Preprocess result stored in the folder: metacyto/panel/preprocess_output

files=list.files("metacyto/panel",pattern="processed_sample",recursive=TRUE,full.names=TRUE)

cs<- load_cytoset(path = "cytosets/tcell")
new<- markernames(cs)
channels_to_exclude <- c(grep(colnames(cs), pattern="FSC"),
                         grep(colnames(cs), pattern="SSC"),
                         grep(colnames(cs), pattern="Time"))
old <- colnames(cs)[-channels_to_exclude]
old<- toupper(old)
oldplus<-paste0(old,"+")
oldminus<-paste0(old,"-")

nameUpdator(oldNames=old, newNames=new, files=files)
nameUpdator(oldNames=oldplus, newNames=new, files=files)
nameUpdator(oldNames=oldminus, newNames=new, files=files)


#define parameters that we don't want to cluster
excludeClusterParameters=c("FSC-A","FSC-W","FSC-H","SSC-A","SSC-W","SSC-H","Time")

cluster_label=autoCluster.batch(preprocessOutputFolder="metacyto/panel/preprocess_output",
                                excludeClusterParameters=excludeClusterParameters,
                                labelQuantile=0.95,
                                minPercent = 0.05,
                                clusterFunction=flowSOM.MC)
## Clustering , study ID =  Colon
## Building SOM
## Mapping data to SOM
## Building MST
## Clustering , study ID =  Ileum
## Building SOM
## Mapping data to SOM
## Building MST
## Clustering , study ID =  Jejunum
## Building SOM
## Mapping data to SOM
## Building MST
## Clustering , study ID =  Whole blood
## Building SOM
## Mapping data to SOM
## Building MST
## Clustering , study ID =  Lung lymph node
## Building SOM
## Mapping data to SOM
## Building MST
## Clustering , study ID =  Inguinal lymph node
## Building SOM
## Mapping data to SOM
## Building MST
## Clustering , study ID =  Lung
## Building SOM
## Mapping data to SOM
## Building MST
## Clustering , study ID =  Spleen
## Building SOM
## Mapping data to SOM
## Building MST
## Clustering , study ID =  PBMC
## Building SOM
## Mapping data to SOM
## Building MST

searchCluster.batch(preprocessOutputFolder="metacyto/panel/preprocess_output",
                    outpath="metacyto/panel/search_output",
                    clusterLabel=cluster_label)
## Searching , study ID =  Colon
## Searching , study ID =  Ileum
## Searching , study ID =  Jejunum
## Searching , study ID =  Whole blood
## Searching , study ID =  Lung lymph node
## Searching , study ID =  Inguinal lymph node
## Searching , study ID =  Lung
## Searching , study ID =  Spleen
## Searching , study ID =  PBMC

files=list.files("metacyto/panel/search_output",pattern="cluster_stats_in_each_sample",recursive=TRUE,full.names=TRUE)
fcs_stats=collectData(files,longform=TRUE)


# join the cluster summary statistics with sample information
all_data=inner_join(fcs_stats,sample_info,by="fcs_files")

# See the fraction of what clusters are affected by Gender (while controlling for age)
GA=glmAnalysis(value="value",
               variableOfInterst="data.resultFiles.gender",
               parameter="fraction", 
               otherVariables=c("data.resultFiles.maxSubjectAge"),
               studyID="study_id",label="label",
               data=all_data,CILevel=0.95,ifScale=c(TRUE,FALSE))

GA=GA[order(GA$`Effect_size`),]

GA$`label`=as.character(GA$`label`)
w = which((GA$`label`)>15)
```

    ## Warning: Use of `GA$label` is discouraged. Use `label` instead.

    ## Warning: Use of `GA$Effect_size` is discouraged. Use `Effect_size` instead.

![](readme_files/figure-gfm/unnamed-chunk-19-1.png)<!-- -->

Top 20 largest effect size

<table>

<thead>

<tr>

<th style="text-align:left;">

</th>

<th style="text-align:left;">

label

</th>

<th style="text-align:right;">

Effect\_size

</th>

<th style="text-align:right;">

SE

</th>

<th style="text-align:right;">

t\_value

</th>

<th style="text-align:right;">

p\_value

</th>

<th style="text-align:right;">

lower

</th>

<th style="text-align:right;">

upper

</th>

<th style="text-align:right;">

N

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

47

</td>

<td style="text-align:left;">

CD28+|CD3+|CD4+|CD45RO+

</td>

<td style="text-align:right;">

0.8031651

</td>

<td style="text-align:right;">

0.2278789

</td>

<td style="text-align:right;">

3.524526

</td>

<td style="text-align:right;">

0.0008629

</td>

<td style="text-align:right;">

0.3464856

</td>

<td style="text-align:right;">

1.2598446

</td>

<td style="text-align:right;">

66

</td>

</tr>

<tr>

<td style="text-align:left;">

184

</td>

<td style="text-align:left;">

CD28+|CD4+|CD45RO+

</td>

<td style="text-align:right;">

0.7426466

</td>

<td style="text-align:right;">

0.2428331

</td>

<td style="text-align:right;">

3.058260

</td>

<td style="text-align:right;">

0.0034352

</td>

<td style="text-align:right;">

0.2559982

</td>

<td style="text-align:right;">

1.2292949

</td>

<td style="text-align:right;">

66

</td>

</tr>

<tr>

<td style="text-align:left;">

85

</td>

<td style="text-align:left;">

CCR7+|CD19+|CD31+|CD4+|CD45RO+|CD8+

</td>

<td style="text-align:right;">

0.7358015

</td>

<td style="text-align:right;">

0.2545410

</td>

<td style="text-align:right;">

2.890700

</td>

<td style="text-align:right;">

0.0056343

</td>

<td style="text-align:right;">

0.2247892

</td>

<td style="text-align:right;">

1.2468138

</td>

<td style="text-align:right;">

61

</td>

</tr>

<tr>

<td style="text-align:left;">

128

</td>

<td style="text-align:left;">

CCR7+|CD19+|CD3+|CD31+|CD4+|CD45RO+|CD8+

</td>

<td style="text-align:right;">

0.7305022

</td>

<td style="text-align:right;">

0.2551306

</td>

<td style="text-align:right;">

2.863248

</td>

<td style="text-align:right;">

0.0060710

</td>

<td style="text-align:right;">

0.2183061

</td>

<td style="text-align:right;">

1.2426982

</td>

<td style="text-align:right;">

61

</td>

</tr>

<tr>

<td style="text-align:left;">

205

</td>

<td style="text-align:left;">

CD4+|CD45RO+

</td>

<td style="text-align:right;">

0.7237409

</td>

<td style="text-align:right;">

0.2444161

</td>

<td style="text-align:right;">

2.961102

</td>

<td style="text-align:right;">

0.0045181

</td>

<td style="text-align:right;">

0.2339201

</td>

<td style="text-align:right;">

1.2135616

</td>

<td style="text-align:right;">

66

</td>

</tr>

<tr>

<td style="text-align:left;">

203

</td>

<td style="text-align:left;">

CD28+|CD3+|CD4+|CD45RO+|CD8+

</td>

<td style="text-align:right;">

0.7039717

</td>

<td style="text-align:right;">

0.2343360

</td>

<td style="text-align:right;">

3.004113

</td>

<td style="text-align:right;">

0.0041215

</td>

<td style="text-align:right;">

0.2335226

</td>

<td style="text-align:right;">

1.1744207

</td>

<td style="text-align:right;">

61

</td>

</tr>

<tr>

<td style="text-align:left;">

30

</td>

<td style="text-align:left;">

CCR7+|CD19+

</td>

<td style="text-align:right;">

0.6178449

</td>

<td style="text-align:right;">

0.2168472

</td>

<td style="text-align:right;">

2.849217

</td>

<td style="text-align:right;">

0.0061552

</td>

<td style="text-align:right;">

0.1832733

</td>

<td style="text-align:right;">

1.0524165

</td>

<td style="text-align:right;">

66

</td>

</tr>

<tr>

<td style="text-align:left;">

78

</td>

<td style="text-align:left;">

CCR7+|CD19+|CD45RO+

</td>

<td style="text-align:right;">

0.6075617

</td>

<td style="text-align:right;">

0.2304315

</td>

<td style="text-align:right;">

2.636626

</td>

<td style="text-align:right;">

0.0108627

</td>

<td style="text-align:right;">

0.1457666

</td>

<td style="text-align:right;">

1.0693569

</td>

<td style="text-align:right;">

66

</td>

</tr>

<tr>

<td style="text-align:left;">

103

</td>

<td style="text-align:left;">

CCR7+|CD19+|CD31+|CD4+|CD45RO+

</td>

<td style="text-align:right;">

0.5967158

</td>

<td style="text-align:right;">

0.2418360

</td>

<td style="text-align:right;">

2.467439

</td>

<td style="text-align:right;">

0.0167492

</td>

<td style="text-align:right;">

0.1120655

</td>

<td style="text-align:right;">

1.0813660

</td>

<td style="text-align:right;">

66

</td>

</tr>

<tr>

<td style="text-align:left;">

11

</td>

<td style="text-align:left;">

CD127-|CD19+|CD4+|CD45RO+|CD8+

</td>

<td style="text-align:right;">

0.5930820

</td>

<td style="text-align:right;">

0.2192813

</td>

<td style="text-align:right;">

2.704663

</td>

<td style="text-align:right;">

0.0095541

</td>

<td style="text-align:right;">

0.1516916

</td>

<td style="text-align:right;">

1.0344725

</td>

<td style="text-align:right;">

55

</td>

</tr>

<tr>

<td style="text-align:left;">

104

</td>

<td style="text-align:left;">

CCR7+|CD19+|CD31+|CD4+

</td>

<td style="text-align:right;">

0.5903663

</td>

<td style="text-align:right;">

0.2410285

</td>

<td style="text-align:right;">

2.449363

</td>

<td style="text-align:right;">

0.0175242

</td>

<td style="text-align:right;">

0.1073343

</td>

<td style="text-align:right;">

1.0733983

</td>

<td style="text-align:right;">

66

</td>

</tr>

<tr>

<td style="text-align:left;">

132

</td>

<td style="text-align:left;">

CCR7+|CD3+|CD45RO+

</td>

<td style="text-align:right;">

0.5903451

</td>

<td style="text-align:right;">

0.2647291

</td>

<td style="text-align:right;">

2.229997

</td>

<td style="text-align:right;">

0.0298485

</td>

<td style="text-align:right;">

0.0598160

</td>

<td style="text-align:right;">

1.1208741

</td>

<td style="text-align:right;">

66

</td>

</tr>

<tr>

<td style="text-align:left;">

74

</td>

<td style="text-align:left;">

CCR7+|CD19+|CD28+|CD31+|CD4+|CD45RA+|CD45RO+|CD8+

</td>

<td style="text-align:right;">

0.5826280

</td>

<td style="text-align:right;">

0.2760517

</td>

<td style="text-align:right;">

2.110576

</td>

<td style="text-align:right;">

0.0397328

</td>

<td style="text-align:right;">

0.0284311

</td>

<td style="text-align:right;">

1.1368248

</td>

<td style="text-align:right;">

61

</td>

</tr>

<tr>

<td style="text-align:left;">

213

</td>

<td style="text-align:left;">

CD19+|CD3+|CD45RA+|CD45RO+

</td>

<td style="text-align:right;">

0.5573624

</td>

<td style="text-align:right;">

0.2245925

</td>

<td style="text-align:right;">

2.481660

</td>

<td style="text-align:right;">

0.0161614

</td>

<td style="text-align:right;">

0.1072689

</td>

<td style="text-align:right;">

1.0074559

</td>

<td style="text-align:right;">

66

</td>

</tr>

<tr>

<td style="text-align:left;">

151

</td>

<td style="text-align:left;">

CD4+

</td>

<td style="text-align:right;">

0.5528965

</td>

<td style="text-align:right;">

0.2464158

</td>

<td style="text-align:right;">

2.243754

</td>

<td style="text-align:right;">

0.0288942

</td>

<td style="text-align:right;">

0.0590682

</td>

<td style="text-align:right;">

1.0467248

</td>

<td style="text-align:right;">

66

</td>

</tr>

<tr>

<td style="text-align:left;">

17

</td>

<td style="text-align:left;">

CCR7+|CD19+|CD28+|CD45RO+|CD8+

</td>

<td style="text-align:right;">

0.5446699

</td>

<td style="text-align:right;">

0.2295150

</td>

<td style="text-align:right;">

2.373134

</td>

<td style="text-align:right;">

0.0214444

</td>

<td style="text-align:right;">

0.0838993

</td>

<td style="text-align:right;">

1.0054405

</td>

<td style="text-align:right;">

61

</td>

</tr>

<tr>

<td style="text-align:left;">

95

</td>

<td style="text-align:left;">

CCR7+|CD19+|CD28+|CD31+|CD4+|CD45RA+|CD8+

</td>

<td style="text-align:right;">

0.5394233

</td>

<td style="text-align:right;">

0.2465378

</td>

<td style="text-align:right;">

2.187994

</td>

<td style="text-align:right;">

0.0329366

</td>

<td style="text-align:right;">

0.0453505

</td>

<td style="text-align:right;">

1.0334961

</td>

<td style="text-align:right;">

66

</td>

</tr>

<tr>

<td style="text-align:left;">

120

</td>

<td style="text-align:left;">

CCR7+|CD19+|CD28+|CD3+|CD4+|CD45RA+

</td>

<td style="text-align:right;">

0.5315369

</td>

<td style="text-align:right;">

0.2320631

</td>

<td style="text-align:right;">

2.290484

</td>

<td style="text-align:right;">

0.0258510

</td>

<td style="text-align:right;">

0.0664721

</td>

<td style="text-align:right;">

0.9966016

</td>

<td style="text-align:right;">

66

</td>

</tr>

<tr>

<td style="text-align:left;">

136

</td>

<td style="text-align:left;">

CD19+|CD45RA+

</td>

<td style="text-align:right;">

0.5297685

</td>

<td style="text-align:right;">

0.2182681

</td>

<td style="text-align:right;">

2.427146

</td>

<td style="text-align:right;">

0.0185209

</td>

<td style="text-align:right;">

0.0923495

</td>

<td style="text-align:right;">

0.9671875

</td>

<td style="text-align:right;">

66

</td>

</tr>

<tr>

<td style="text-align:left;">

226

</td>

<td style="text-align:left;">

CCR7+|CD19+|CD28+|CD3+|CD31+|CD4+|CD45RA+|CD45RO+|CD69+|CD8+

</td>

<td style="text-align:right;">

0.5258602

</td>

<td style="text-align:right;">

0.2900366

</td>

<td style="text-align:right;">

1.813083

</td>

<td style="text-align:right;">

0.0763471

</td>

<td style="text-align:right;">

\-0.0579531

</td>

<td style="text-align:right;">

1.1096735

</td>

<td style="text-align:right;">

55

</td>

</tr>

</tbody>

</table>

  - Coming soon:
      - CyTOF data support
  - Please contact me with ANY questions, comments or suggestions\!\!\!
      - Slack: Join the [immunespace
        slack\!](https://immunespace.slack.com/archives/DFU59KGUD)
      - iMessage: mrjaffery at icloud dot com
      - email: mrjaffery at gmail dot com
