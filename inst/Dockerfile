FROM jpwagner/cytoverse:devel


# INSTALL DEPENDENCIES
RUN R -e "install.packages('plotly')" && \
	R -e "install.packages('stringr')" && \
    R -e "BiocManager::install('MetaCyto')" && \
    R -e "remotes::install_github('RGLab/ImmPortR')" && \
    R -e "remotes::install_github('mrj31/immdonor')" 
	
	
    

