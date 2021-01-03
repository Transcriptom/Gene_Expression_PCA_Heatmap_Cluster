# Container image that runs your code
FROM rocker/r-ver:4.0.3 

MAINTAINER Zan Yuan <seqyuan@gmail.com>
ENV LANG=en_US.UTF-8

RUN R -e "install.packages(c('ggplot2','BiocManager'))"
RUN R -e "BiocManager::install(c('patchwork','cowplot'))"

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY FPKM_PCA_Heatmap_Cluster.R /FPKM_PCA_Heatmap_Cluster.R

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
