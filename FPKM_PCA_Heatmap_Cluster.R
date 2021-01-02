args = commandArgs(trailingOnly=TRUE)
if (length(args)!=2) {
	stop("Rscript FPKM_PCA_Heatmap_Cluster.R fpkm.xls group.txt")
}

library(ggplot2)

df <-read.csv(args[1], header=T, sep="\t", row.names=1)
pca <- prcomp(t(df), scale=TRUE)
pca.var <- pca$sdev^2
pca.var.per <- round(pca.var/sum(pca.var)*100, 1)

mat <- as.data.frame(pca$x[,1:2])
mat$sample <- rownames(mat)

group <- read.csv(args[2], header=F, sep="\t",row.names = 1)
colnames(group) <- c("group")
mat <- cbind(mat,group)

p_PCA <- ggplot(data=mat,aes(x=PC1,y=PC2,color=sample,shape=group))+
  geom_point(size=3) +
  theme_bw()+theme(panel.grid=element_blank()) +
  xlab(paste("PC1(",pca.var.per[1],"%","variance)",sep=""))+
  ylab(paste("PC2(",pca.var.per[2],"%","variance)",sep=""))

library("cowplot")

pdf('pca.pdf',width=4, height=9)
plot_grid(p_PCA, labels = c("PCA"), ncol = 1, nrow = 3)
dev.off()

