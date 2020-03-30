{r}
###load packages
library('reshape2')
library('ggrepel')
library('tidyr')
library('ggpubr')
library('RColorBrewer')
library('scales')
library('dplyr')
library("ggpointdensity")
library('viridis')
library('cowplot')
library('ggrastr')
library("ggpubr")


#load data
met_L1mdF <- read.delim(file = "L1MdF_5kb.txt")
met_L1mdA <- read.delim(file = "L1MdA_5kb.txt")
met_L1mdGf <- read.delim(file = "L1MdGf_5kb.txt")
met_L1mdT <- read.delim(file = "L1MdT_5kb.txt")
met_IAP <- read.delim(file = "IAP_6kb.txt")
met_IAPEy <- read.delim(file = "IAPEy_6kb.txt")
met_IAPEz <- read.delim(file = "IAPEz_6kb.txt")
met_MMERVK10c <- read.delim(file = "MMERVK10c.txt")
met_ERVL <- read.delim(file = "ERVL.txt")
met_ERVK <- read.delim(file = "ERVK.txt")
met_L1 <- read.delim(file="L1_5kb.txt")
met_SINE <- read.delim(file = "SINE.txt")
met_allProbes <- read.delim(file = "allProbes.txt")
met_genic <- read.delim(file = "genic.txt")
met_intergenic <- read.delim(file = "intergenic.txt")
met_CGI <- read.delim(file = "cgi.txt")
met_repeats <- read.delim(file = "repeats.txt")
met_promoter <- read.delim(file = "promoter.txt")


###tidy dataset
L1MdA_met_tidy <- met_L1mdA %>% distinct() %>% 
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2KO, Mean.Tex15KO, Mean.WT_ansgar) 

L1MdT_met_tidy <- met_L1mdT %>% distinct() %>% 
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2KO, Mean.Tex15KO, Mean.WT_ansgar) 

L1MdF_met_tidy <- met_L1mdF %>% distinct() %>%
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2KO, Mean.Tex15KO, Mean.WT_ansgar)

L1MdGf_met_tidy <- met_L1mdGf %>% distinct() %>% 
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2KO, Mean.Tex15KO, Mean.WT_ansgar) 

IAP_met_tidy <- met_IAP %>% distinct() %>% 
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2KO, Mean.Tex15KO, Mean.WT_ansgar) 

IAPEy_met_tidy <- met_IAPEy %>% distinct() %>%
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2KO, Mean.Tex15KO, Mean.WT_ansgar) 

IAPEz_met_tidy <- met_IAPEz %>% distinct() %>% 
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2KO, Mean.Tex15KO, Mean.WT_ansgar) 

MMERVK10c_met_tidy <- met_MMERVK10c %>% distinct() %>%
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2KO, Mean.Tex15KO, Mean.WT_ansgar)

ERVK_met_tidy <- met_ERVK %>% distinct() %>%
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2KO, Mean.Tex15KO, Mean.WT_ansgar)

ERVL_met_tidy <- met_ERVL %>% distinct() %>%
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2KO, Mean.Tex15KO, Mean.WT_ansgar)

L1_met_tidy <- met_L1 %>% distinct() %>% 
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2KO, Mean.Tex15KO, Mean.WT_ansgar)

SINE_met_tidy <- met_SINE %>% distinct() %>% 
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2KO, Mean.Tex15KO, Mean.WT_ansgar)

allProbes_met_tidy <- met_allProbes %>% distinct() %>% 
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2KO, Mean.Tex15KO, Mean.WT_ansgar)

genic_met_tidy <- met_genic %>% distinct() %>% 
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2KO, Mean.Tex15KO, Mean.WT_ansgar)

intergenic_met_tidy <- met_intergenic %>% distinct() %>% 
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2KO, Mean.Tex15KO, Mean.WT_ansgar)

CGI_met_tidy <- met_CGI %>% distinct() %>% 
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2KO, Mean.Tex15KO, Mean.WT_ansgar)

repeats_met_tidy <- met_repeats %>% distinct() %>% 
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2KO, Mean.Tex15KO, Mean.WT_ansgar)

promoter_met_tidy <- met_promoter %>% distinct() %>% 
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2KO, Mean.Tex15KO, Mean.WT_ansgar)

###plot data
#L1MdA_met_tidy
L1MdA_met_miwi2_plot <- ggplot(data = L1MdA_met_tidy, mapping = aes(x=Mean.Miwi2KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Miwi2-/-", y = "CpG methylation [%] WT",
        title ="L1Md_A") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))



L1MdA_met_Tex15_plot <- ggplot(data = L1MdA_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) +
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] WT",
        title ="L1Md_A") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

L1MdA_met_Tex15_miwi2_plot <- ggplot(data = L1MdA_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.Miwi2KO)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.Miwi2KO,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] Miwi2-/-",
        title ="L1MdA") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))


#L1MdF_met_tidy
L1MdF_met_miwi2_plot <- ggplot(data = L1MdF_met_tidy, mapping = aes(x=Mean.Miwi2KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) +
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Miwi2-/-", y = "CpG methylation [%] WT",
        title ="L1Md_F") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))



L1MdF_met_Tex15_plot <- ggplot(data = L1MdF_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) +
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] WT",
        title ="L1Md_F") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

L1MdF_met_Tex15_miwi2_plot <- ggplot(data = L1MdF_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.Miwi2KO)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.Miwi2KO,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] Miwi2-/-",
        title ="L1MdF") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

#L1MdGf_met_tidy
L1MdGf_met_miwi2_plot <- ggplot(data = L1MdGf_met_tidy, mapping = aes(x=Mean.Miwi2KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) +
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Miwi2-/-", y = "CpG methylation [%] WT",
        title ="L1Md_Gf") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))


L1MdGf_met_Tex15_plot <- ggplot(data = L1MdGf_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) +
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] WT",
        title ="L1Md_Gf") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

L1MdGf_met_Tex15_miwi2_plot <- ggplot(data = L1MdGf_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.Miwi2KO)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.Miwi2KO,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] Miwi2-/-",
        title ="L1MdGf") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

#L1MdT_met_tidy
L1MdT_met_miwi2_plot <- ggplot(data = L1MdT_met_tidy, mapping = aes(x=Mean.Miwi2KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) +
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Miwi2-/-", y = "CpG methylation [%] WT",
        title ="L1Md_T") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))



L1MdT_met_Tex15_plot <- ggplot(data = L1MdT_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) +
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] WT",
        title ="L1Md_T") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

L1MdT_met_Tex15_miwi2_plot <- ggplot(data = L1MdT_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.Miwi2KO)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.Miwi2KO,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] Miwi2-/-",
        title ="L1Md_T") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

#L1_met_tidy
L1_met_miwi2_plot <- ggplot(data = L1_met_tidy, mapping = aes(x=Mean.Miwi2KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Miwi2-/-", y = "CpG methylation [%] WT",
        title ="L1") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))



L1_met_Tex15_plot <- ggplot(data = L1_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] WT",
        title ="L1") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

L1_met_Tex15_miwi2_plot <- ggplot(data = L1_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.Miwi2KO)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.Miwi2KO,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] Miwi2-/-",
        title ="L1") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

#IAP_met_tidy
IAP_met_miwi2_plot <- ggplot(data = IAP_met_tidy, mapping = aes(x=Mean.Miwi2KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Miwi2-/-", y = "CpG methylation [%] WT",
        title ="IAP") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))


IAP_met_Tex15_plot <- ggplot(data = IAP_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] WT",
        title ="IAP") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

IAP_met_Tex15_miwi2_plot <- ggplot(data = IAP_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.Miwi2KO)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.Miwi2KO,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] Miwi2-/-",
        title ="IAP") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

#IAPEz_met_tidy
IAPEz_met_miwi2_plot <- ggplot(data = IAPEz_met_tidy, mapping = aes(x=Mean.Miwi2KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Miwi2-/-", y = "CpG methylation [%] WT",
        title ="IAPEz") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))



IAPEz_met_Tex15_plot <- ggplot(data = IAPEz_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] WT",
        title ="IAPEz") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

IAPEz_met_Tex15_miwi2_plot <- ggplot(data = IAPEz_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.Miwi2KO)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.Miwi2KO,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] Miwi2-/-",
        title ="IAPEz") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

#IAPEy_met_tidy
IAPEy_met_miwi2_plot <- ggplot(data = IAPEy_met_tidy, mapping = aes(x=Mean.Miwi2KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Miwi2-/-", y = "CpG methylation [%] WT",
        title ="IAPEy") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))



IAPEy_met_Tex15_plot <- ggplot(data = IAPEy_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] WT",
        title ="IAPEy") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))


IAPEy_met_Tex15_miwi2_plot <- ggplot(data = IAPEy_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.Miwi2KO)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.Miwi2KO,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] Miwi2-/-",
        title ="IAPEy") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

#MMERVK10c_met_tidy
MMERVK10c_met_miwi2_plot <- ggplot(data = MMERVK10c_met_tidy, mapping = aes(x=Mean.Miwi2KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Miwi2-/-", y = "CpG methylation [%] WT",
        title ="MMERVK10c") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))



MMERVK10c_met_Tex15_plot <- ggplot(data = MMERVK10c_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] WT",
        title ="MMERVK10c") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))


MMERVK10c_met_Tex15_miwi2_plot <- ggplot(data = MMERVK10c_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.Miwi2KO)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.Miwi2KO,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] Miwi2-/-",
        title ="MMERVK10c") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

#met_ERVL
ERVL_met_miwi2_plot <- ggplot(data = ERVL_met_tidy, mapping = aes(x=Mean.Miwi2KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Miwi2-/-", y = "CpG methylation [%] WT",
        title ="ERVL") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))



ERVL_met_Tex15_plot <- ggplot(data = ERVL_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] WT",
        title ="ERVL") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

ERVL_met_Tex15_miwi2_plot <- ggplot(data = ERVL_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.Miwi2KO)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.Miwi2KO,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] Miwi2-/-",
        title ="ERVL") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))



#ERVK met
ERVK_met_miwi2_plot <- ggplot(data = ERVK_met_tidy, mapping = aes(x=Mean.Miwi2KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Miwi2-/-", y = "CpG methylation [%] WT",
        title ="ERVK") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))


ERVK_met_Tex15_plot <- ggplot(data = ERVK_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] WT",
        title ="ERVK") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

ERVK_met_Tex15_miwi2_plot <- ggplot(data = ERVK_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.Miwi2KO)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.Miwi2KO,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] Miwi2-/-",
        title ="ERVK") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))



#met_SINE
SINE_met_miwi2_plot <- ggplot(data = SINE_met_tidy, mapping = aes(x=Mean.Miwi2KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Miwi2-/-", y = "CpG methylation [%] WT",
        title ="SINE") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))



SINE_met_Tex15_plot <- ggplot(data = SINE_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] WT",
        title ="SINE") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

SINE_met_Tex15_miwi2_plot <- ggplot(data = SINE_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.Miwi2KO)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.Miwi2KO,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] Miwi2-/-",
        title ="SINE") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))



#met_allProbes
allProbes_met_miwi2_plot <- ggplot(data = allProbes_met_tidy, mapping = aes(x=Mean.Miwi2KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Miwi2-/-", y = "CpG methylation [%] WT",
        title ="all Probes") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))


allProbes_met_Tex15_plot <- ggplot(data = allProbes_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] WT",
        title ="all Probes") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

allProbes_met_Tex15_miwi2_plot <- ggplot(data = allProbes_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.Miwi2KO)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.Miwi2KO,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] Miwi2-/-",
        title ="all Probes") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))


#met_genic
genic_met_miwi2_plot <- ggplot(data = genic_met_tidy, mapping = aes(x=Mean.Miwi2KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Miwi2-/-", y = "CpG methylation [%] WT",
        title ="genic") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))



genic_met_Tex15_plot <- ggplot(data = genic_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] WT",
        title ="genic") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

genic_met_Tex15_miwi2_plot <- ggplot(data = genic_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.Miwi2KO)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.Miwi2KO,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] Miwi2-/-",
        title ="genic") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))



#met_intergenic
intergenic_met_miwi2_plot <- ggplot(data = intergenic_met_tidy, mapping = aes(x=Mean.Miwi2KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Miwi2-/-", y = "CpG methylation [%] WT",
        title ="intergenic") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))



intergenic_met_Tex15_plot <- ggplot(data = intergenic_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] WT",
        title ="intergenic") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

intergenic_met_Tex15_miwi2_plot <- ggplot(data = intergenic_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.Miwi2KO)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.Miwi2KO,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] Miwi2-/-",
        title ="intergenic") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))



#met_CGI
CGI_met_miwi2_plot <- ggplot(data = CGI_met_tidy, mapping = aes(x=Mean.Miwi2KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Miwi2-/-", y = "CpG methylation [%] WT",
        title ="CGI") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))


CGI_met_Tex15_plot <- ggplot(data = CGI_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] WT",
        title ="CGI") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

CGI_met_Tex15_miwi2_plot <- ggplot(data = CGI_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.Miwi2KO)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.Miwi2KO,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] Miwi2-/-",
        title ="CGI") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))


#met_repeats
repeats_met_miwi2_plot <- ggplot(data = repeats_met_tidy, mapping = aes(x=Mean.Miwi2KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Miwi2-/-", y = "CpG methylation [%] WT",
        title ="Repeats") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

repeats_met_Tex15_plot <- ggplot(data = repeats_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] WT",
        title ="Repeats") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

repeats_met_Tex15_miwi2_plot <- ggplot(data = repeats_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.Miwi2KO)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.Miwi2KO,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] Miwi2-/-",
        title ="repeats") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))


#promoter_repeats
promoter_met_miwi2_plot <- ggplot(data = promoter_met_tidy, mapping = aes(x=Mean.Miwi2KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Miwi2-/-", y = "CpG methylation [%] WT",
        title ="Promoter") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))


promoter_met_Tex15_plot <- ggplot(data = promoter_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.WT_ansgar)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.WT_ansgar,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] WT",
        title ="Promoter") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

promoter_met_Tex15_miwi2_plot <- ggplot(data = promoter_met_tidy, mapping = aes(x=Mean.Tex15KO, y=Mean.Miwi2KO)) +
  geom_point_rast(colour="darkgrey",alpha=0.5,size=I(1.2)) +
  stat_density2d(aes(Mean.Tex15KO,Mean.Miwi2KO,alpha=..level..,fill=..level..), geom="polygon",contour=TRUE,n=500,bins=30) + 
  scale_color_viridis() +
  scale_fill_gradientn(colours = colorRampPalette(c("darkblue", "midnightblue","dodgerblue", "white"))(100),guide=F)+
  scale_alpha_continuous(range = c(0, 0.35))+
  labs( x = "CpG methylation [%] Tex15-/-", y = "CpG methylation [%] Miwi2-/-",
        title ="Promoter") +
  stat_cor(method = "spearman", label.x = 75, label.y = 3)+
  coord_cartesian(ylim = c(0, 100), xlim = c(0,100)) +
  theme_classic() +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=10),
        title=element_text(size=10),
        legend.position="none", plot.title = element_text(hjust = 0.5))

#plot_grid(allProbes_met_miwi2_plot, allProbes_met_Tex15_plot, labels = c('A', 'B'), label_size = 12)

pdf("Met_scatter_genome_density.pdf")
plot_grid(CGI_met_miwi2_plot, CGI_met_Tex15_plot, 
          genic_met_miwi2_plot, genic_met_Tex15_plot, 
          intergenic_met_miwi2_plot, intergenic_met_Tex15_plot, 
          labels = c('A', 'B', 'C', 'D', 'E', 'F'), label_size = 12)
dev.off()

pdf("Met_scatter_L1_density.pdf")
plot_grid(L1MdA_met_miwi2_plot, L1MdA_met_Tex15_plot, 
          L1MdF_met_miwi2_plot, L1MdF_met_Tex15_plot, 
          L1MdT_met_miwi2_plot, L1MdT_met_Tex15_plot, 
          labels = c('A', 'B', 'C', 'D', 'E', 'F'), label_size = 12)
dev.off()


pdf("Met_scatter_IAP_density.pdf")
plot_grid(IAP_met_miwi2_plot, IAP_met_Tex15_plot, 
          IAPEz_met_miwi2_plot, IAPEz_met_Tex15_plot, 
          IAPEy_met_miwi2_plot, IAPEy_met_Tex15_plot, 
          labels = c('A', 'B', 'C', 'D', 'E', 'F'), label_size = 12)
dev.off()

pdf("Met_scatter_ervs_density.pdf")
plot_grid(repeats_met_miwi2_plot, repeats_met_Tex15_plot,
          ERVL_met_miwi2_plot, ERVL_met_Tex15_plot, 
          ERVK_met_miwi2_plot, ERVK_met_Tex15_plot, 
          labels = c('A', 'B', 'C', 'D', 'E', 'F'), label_size = 12)
dev.off()

pdf("Met_scatter_sine_L1_mmervk.pdf")
plot_grid(SINE_met_miwi2_plot, SINE_met_Tex15_plot,
          MMERVK10c_met_miwi2_plot, MMERVK10c_met_Tex15_plot,
          L1_met_miwi2_plot, L1_met_Tex15_plot,
          labels = c('A', 'B', 'C', 'D', 'E', 'F'), label_size = 12)
dev.off()

pdf("Met_scatter_prom_L1mdgf.pdf")
plot_grid(promoter_met_miwi2_plot, promoter_met_Tex15_plot,
          L1MdGf_met_miwi2_plot, L1MdGf_met_Tex15_plot,
          labels = c('A', 'B', 'C', 'D'), label_size = 12)
dev.off()

pdf("Miwi2_Tex15_1.pdf")
plot_grid(allProbes_met_Tex15_miwi2_plot, CGI_met_Tex15_miwi2_plot,
          promoter_met_Tex15_miwi2_plot, genic_met_Tex15_miwi2_plot,
          intergenic_met_Tex15_miwi2_plot, repeats_met_Tex15_miwi2_plot,
          labels = c('A', 'B', 'C', 'D', 'E', 'F'), label_size = 12)
dev.off()

pdf("Miwi2_Tex15_2.pdf")
plot_grid(L1_met_Tex15_miwi2_plot, L1MdA_met_Tex15_miwi2_plot,
          L1MdT_met_Tex15_miwi2_plot, L1MdGf_met_Tex15_miwi2_plot,
          L1MdF_met_Tex15_miwi2_plot, SINE_met_Tex15_miwi2_plot,
          labels = c('A', 'B', 'C', 'D', 'E', 'F'), label_size = 12)
dev.off()

pdf("Miwi2_Tex15_3.pdf")
plot_grid(IAP_met_Tex15_miwi2_plot, IAPEy_met_Tex15_miwi2_plot,
          IAPEz_met_Tex15_miwi2_plot, MMERVK10c_met_Tex15_miwi2_plot,
          ERVL_met_Tex15_miwi2_plot, ERVK_met_Tex15_miwi2_plot,
          labels = c('A', 'B', 'C', 'D', 'E', 'F'), label_size = 12)
dev.off()
