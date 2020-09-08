FROM rglab/cytoverse:devel

RUN apt-get update \
    && apt-get install -y libglpk-dev

# INSTALL DEPENDENCIES
RUN R -e "install.packages('plotly')" && \
R -e "install.packages('tidyverse')" && \
R -e "install.packages('RMySQL')" && \
R -e "install.packages('RMariaDB')" && \
R -e "install.packages('shiny')" && \
R -e "install.packages('knitr')" && \
R -e "install.packages('ghql')" && \
R -e "install.packages('RPostgres')" && \
R -e "install.packages('flexdashboard')" && \
R -e "install.packages('ghql')" && \
R -e "install.packages('visNetwork')" && \
R -e "BiocManager::install('RImmPort')" && \
R -e "BiocManager::install('MetaCyto')" && \
R -e "remotes::install_github('RGLab/ImmPortR')" && \
R -e "remotes::install_github('ropensci/ghql')" && \
R -e "remotes::install_github('neo4j-rstats/neo4r')"
	