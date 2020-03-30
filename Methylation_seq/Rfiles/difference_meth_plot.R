###load packages
library('reshape2')
library('ggrepel')
library('tidyr')
library('ggpubr')
library('RColorBrewer')
library('scales')
library('dplyr')
library(cowplot)

###load data
met_L1mdA <- read.delim(file = "L1MdA_5000.txt")
met_L1mdF <- read.delim(file = "L1MdF_5000.txt")
met_L1mdGf <- read.delim(file = "L1MdGf_5000.txt")
met_L1mdT <- read.delim(file = "L1MdT_5000.txt")
met_IAP <- read.delim(file = "IAP_6000.txt")
met_IAPEy <- read.delim(file = "IAPEy_6000.txt")
met_IAPEz <- read.delim(file = "=IAPEz_6000.txt")
met_MMERVK10c <- read.delim(file = "MMERVK10c_4500.txt")
met_L1 <- read.delim(file="L1_5000.txt")

###tidy dataset
L1MdA_met_tidy_melt <- met_L1mdA %>% 
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2_KO, Mean.Spocd1_KO, Mean.C19_KO, Mean.C19_WT) %>%
  filter(Description!="No description") %>%
  mutate(Miwi2_WT = Mean.Miwi2_KO-Mean.C19_WT, Mean.Spocd1_KO = Mean.Spocd1_KO-Mean.C19_WT, Mean.C19_KO = Mean.C19_KO-Mean.C19_WT) %>%
  melt(ID = c("Chr", "Start", "End", "Strand"), measure.vars = c(10,11), variable.name="Met_diff")

L1MdA_met_tidy <- met_L1mdA %>% distinct() %>% na.omit() %>%
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2_KO, Mean.Spocd1_KO, Mean.C19_KO, Mean.C19_WT) %>%
  filter(Description!="No description") %>% 
  mutate(Miwi2_WT = Mean.Miwi2_KO-Mean.C19_WT, Spocd1_WT = Mean.Spocd1_KO-Mean.C19_WT, C19_WT = Mean.C19_KO-Mean.C19_WT)

L1MdA_met_tidy$Description <- as.integer(L1MdA_met_tidy$Description)
  
L1MdT_met_tidy <- met_L1mdT %>% distinct() %>% na.omit() %>%
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2_KO, Mean.Spocd1_KO, Mean.C19_KO, Mean.C19_WT) %>%
  filter(Description!="No description") %>%
  mutate(Miwi2_WT = Mean.Miwi2_KO-Mean.C19_WT, Spocd1_WT = Mean.Spocd1_KO-Mean.C19_WT, C19_WT = Mean.C19_KO-Mean.C19_WT)

L1MdT_met_tidy$Description <- as.integer(L1MdT_met_tidy$Description)

L1MdF_met_tidy <- met_L1mdF %>% distinct() %>% na.omit() %>%
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2_KO, Mean.Spocd1_KO, Mean.C19_KO, Mean.C19_WT) %>%
  filter(Description!="No description") %>%
  mutate(Miwi2_WT = Mean.Miwi2_KO-Mean.C19_WT, Spocd1_WT = Mean.Spocd1_KO-Mean.C19_WT, C19_WT = Mean.C19_KO-Mean.C19_WT)

L1MdF_met_tidy$Description <- as.integer(L1MdF_met_tidy$Description)

L1MdGf_met_tidy <- met_L1mdGf %>% distinct() %>% na.omit() %>%
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2_KO, Mean.Spocd1_KO, Mean.C19_KO, Mean.C19_WT) %>%
  filter(Description!="No description") %>%
  mutate(Miwi2_WT = Mean.Miwi2_KO-Mean.C19_WT, Spocd1_WT = Mean.Spocd1_KO-Mean.C19_WT, C19_WT = Mean.C19_KO-Mean.C19_WT)

L1MdGf_met_tidy$Description <- as.integer(L1MdGf_met_tidy$Description)

IAP_met_tidy <- met_IAP %>% distinct() %>% na.omit() %>%
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2_KO, Mean.Spocd1_KO, Mean.C19_KO, Mean.C19_WT) %>%
  filter(Description!="No description") %>%
  mutate(Miwi2_WT = Mean.Miwi2_KO-Mean.C19_WT, Spocd1_WT = Mean.Spocd1_KO-Mean.C19_WT, C19_WT = Mean.C19_KO-Mean.C19_WT)

IAP_met_tidy$Description <- as.integer(IAP_met_tidy$Description)

IAPEy_met_tidy <- met_IAPEy %>% distinct() %>% na.omit() %>%
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2_KO, Mean.Spocd1_KO, Mean.C19_KO, Mean.C19_WT) %>%
  filter(Description!="No description") %>%
  mutate(Miwi2_WT = Mean.Miwi2_KO-Mean.C19_WT, Spocd1_WT = Mean.Spocd1_KO-Mean.C19_WT, C19_WT = Mean.C19_KO-Mean.C19_WT)

IAPEy_met_tidy$Description <- as.integer(IAPEy_met_tidy$Description)

IAPEz_met_tidy <- met_IAPEz %>% distinct() %>% na.omit() %>%
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2_KO, Mean.Spocd1_KO, Mean.C19_KO, Mean.C19_WT) %>%
  filter(Description!="No description") %>%
  mutate(Miwi2_WT = Mean.Miwi2_KO-Mean.C19_WT, Spocd1_WT = Mean.Spocd1_KO-Mean.C19_WT, C19_WT = Mean.C19_KO-Mean.C19_WT)

IAPEz_met_tidy$Description <- as.integer(IAPEz_met_tidy$Description)

MMERVK10c_met_tidy <- met_MMERVK10c %>% distinct() %>% na.omit() %>%
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2_KO, Mean.Spocd1_KO, Mean.C19_KO, Mean.C19_WT) %>%
  filter(Description!="No description") %>%
  mutate(Miwi2_WT = Mean.Miwi2_KO-Mean.C19_WT, Spocd1_WT = Mean.Spocd1_KO-Mean.C19_WT, C19_WT = Mean.C19_KO-Mean.C19_WT)

MMERVK10c_met_tidy$Description <- as.integer(MMERVK10c_met_tidy$Description)

L1_met_tidy <- met_L1 %>% distinct() %>% na.omit() %>%
  select(Chr, Start, End, Strand, ID, Description, Mean.Miwi2_KO, Mean.Spocd1_KO, Mean.C19_KO, Mean.C19_WT) %>%
  filter(Description!="No description") %>%
  mutate(Miwi2_WT = Mean.Miwi2_KO-Mean.C19_WT, Spocd1_WT = Mean.Spocd1_KO-Mean.C19_WT, C19_WT = Mean.C19_KO-Mean.C19_WT)

L1_met_tidy$Description <- as.integer(L1_met_tidy$Description)

###plot data
MetDiff_L1MdA_miwi2_plot <- L1MdA_met_tidy %>% ggplot(aes(Description, Miwi2_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss Miwi2",
        title ="L1Md_A") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))


MetDiff_L1MdA_spocd1_plot <- L1MdA_met_tidy %>% ggplot(aes(Description, Spocd1_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss Spocd1",
        title ="L1Md_A") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))

MetDiff_L1MdA_c19_plot <- L1MdA_met_tidy %>% ggplot(aes(Description, C19_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss C19",
        title ="L1Md_A") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))



MetDiff_L1MdT_miwi2_plot <- L1MdT_met_tidy %>% ggplot(aes(Description, Miwi2_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss Miwi2",
        title ="L1Md_T") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))


MetDiff_L1MdT_spocd1_plot <- L1MdT_met_tidy %>% ggplot(aes(Description, Spocd1_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss Spocd1",
        title ="L1Md_T") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))

MetDiff_L1MdT_c19_plot <- L1MdT_met_tidy %>% ggplot(aes(Description, C19_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss C19",
        title ="L1Md_T") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))


MetDiff_L1MdF_miwi2_plot <- L1MdF_met_tidy %>% ggplot(aes(Description, Miwi2_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss Miwi2",
        title ="L1Md_F") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))


MetDiff_L1MdF_spocd1_plot <- L1MdF_met_tidy %>% ggplot(aes(Description, Spocd1_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss Spocd1",
        title ="L1Md_F") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))

MetDiff_L1MdF_c19_plot <- L1MdF_met_tidy %>% ggplot(aes(Description, C19_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss C19",
        title ="L1Md_F") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))


MetDiff_L1MdGf_miwi2_plot <- L1MdGf_met_tidy %>% ggplot(aes(Description, Miwi2_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss Miwi2",
        title ="L1Md_Gf") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))


MetDiff_L1MdGf_spocd1_plot <- L1MdGf_met_tidy %>% ggplot(aes(Description, Spocd1_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss Spocd1",
        title ="L1Md_Gf") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))

MetDiff_L1MdGf_c19_plot <- L1MdGf_met_tidy %>% ggplot(aes(Description, C19_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss C19",
        title ="L1Md_Gf") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))



MetDiff_L1_miwi2_plot <- L1_met_tidy %>% ggplot(aes(Description, Miwi2_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss Miwi2",
        title ="L1") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))


MetDiff_L1_spocd1_plot <- L1_met_tidy %>% ggplot(aes(Description, Spocd1_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss Spocd1",
        title ="L1") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))

MetDiff_L1_c19_plot <- L1_met_tidy %>% ggplot(aes(Description, C19_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss C19",
        title ="L1") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))

MetDiff_IAP_miwi2_plot <- IAP_met_tidy %>% ggplot(aes(Description, Miwi2_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss Miwi2",
        title ="IAP") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))


MetDiff_IAP_spocd1_plot <- IAP_met_tidy %>% ggplot(aes(Description, Spocd1_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss Spocd1",
        title ="IAP") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))

MetDiff_IAP_c19_plot <- IAP_met_tidy %>% ggplot(aes(Description, C19_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss C19",
        title ="IAP") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))

MetDiff_IAPEy_miwi2_plot <- IAPEy_met_tidy %>% ggplot(aes(Description, Miwi2_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss Miwi2",
        title ="IAPEy") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))


MetDiff_IAPEy_spocd1_plot <- IAPEy_met_tidy %>% ggplot(aes(Description, Spocd1_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss Spocd1",
        title ="IAPEy") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))

MetDiff_IAPEy_c19_plot <- IAPEy_met_tidy %>% ggplot(aes(Description, C19_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss C19",
        title ="IAPEy") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))


MetDiff_IAPEz_miwi2_plot <- IAPEz_met_tidy %>% ggplot(aes(Description, Miwi2_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss Miwi2",
        title ="IAPEz") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))


MetDiff_IAPEz_spocd1_plot <- IAPEz_met_tidy %>% ggplot(aes(Description, Spocd1_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss Spocd1",
        title ="IAPEz") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))

MetDiff_IAPEz_c19_plot <- IAPEz_met_tidy %>% ggplot(aes(Description, C19_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss C19",
        title ="IAPEz") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))


MetDiff_MMERVK10c_miwi2_plot <- MMERVK10c_met_tidy %>% ggplot(aes(Description, Miwi2_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss Miwi2",
        title ="MMERVK10c") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))


MetDiff_MMERVK10c_spocd1_plot <- MMERVK10c_met_tidy %>% ggplot(aes(Description, Spocd1_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss Spocd1",
        title ="MMERVK10c") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))

MetDiff_MMERVK10c_c19_plot <- MMERVK10c_met_tidy %>% ggplot(aes(Description, C19_WT)) +
  geom_point(alpha=.5) +
  labs( x = "Consensus mismatch sites per kb", y = "CpG methylation [%] loss C19",
        title ="MMERVK10c") +
  coord_cartesian(ylim = c(20, -100), xlim = c(0,300)) +
  theme_classic() +
  theme(axis.text=element_text(size=6),
        axis.title=element_text(size=6),
        title=element_text(size=10))



png("Met_diffplots_spocd1.png")
plot_grid(MetDiff_L1_spocd1_plot, MetDiff_L1MdA_spocd1_plot,
          MetDiff_L1MdT_spocd1_plot, MetDiff_L1MdF_spocd1_plot, 
          MetDiff_L1MdGf_spocd1_plot, MetDiff_IAP_spocd1_plot, 
          MetDiff_IAPEy_spocd1_plot, MetDiff_IAPEz_spocd1_plot, 
          MetDiff_MMERVK10C_spocd1_plot, 
          labels = c('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'), label_size = 12)
dev.off()

png("Met_diffplots_tex15.png")
plot_grid(MetDiff_L1_miwi2_plot, MetDiff_L1MdA_miwi2_plot,
          MetDiff_L1MdT_miwi2_plot, MetDiff_L1MdF_miwi2_plot, 
          MetDiff_L1MdGf_miwi2_plot, MetDiff_IAP_miwi2_plot, 
          MetDiff_IAPEy_miwi2_plot, MetDiff_IAPEz_miwi2_plot, 
          MetDiff_MMERVK10C_miwi2_plot, 
          labels = c('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'), label_size = 12)
dev.off()

png("Met_diffplots_c19.png")
plot_grid(MetDiff_L1_c19_plot, MetDiff_L1MdA_c19_plot,
          MetDiff_L1MdT_c19_plot, MetDiff_L1MdF_c19_plot, 
          MetDiff_L1MdGf_c19_plot, MetDiff_IAP_c19_plot, 
          MetDiff_IAPEy_c19_plot, MetDiff_IAPEz_c19_plot, 
          MetDiff_MMERVK10C_c19_plot, 
          labels = c('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'), label_size = 12)
dev.off()


pdf("Met_diffplots_c19.pdf")
MetDiff_L1_c19_plot
MetDiff_L1MdA_c19_plot
MetDiff_L1MdT_c19_plot
MetDiff_L1MdF_c19_plot
MetDiff_L1MdGf_c19_plot
MetDiff_IAP_c19_plot
MetDiff_IAPEy_c19_plot
MetDiff_IAPEz_c19_plot
MetDiff_MMERVK10C_c19_plot
dev.off()

pdf("Met_diffplots_miwi2.pdf")
MetDiff_L1_miwi2_plot
MetDiff_L1MdA_miwi2_plot
MetDiff_L1MdT_miwi2_plot
MetDiff_L1MdF_miwi2_plot
MetDiff_L1MdGf_miwi2_plot
MetDiff_IAP_miwi2_plot
MetDiff_IAPEy_miwi2_plot
MetDiff_IAPEz_miwi2_plot
MetDiff_MMERVK10C_miwi2_plot
dev.off()

pdf("Met_diffplots_spocd1.pdf")
MetDiff_L1_spocd1_plot
MetDiff_L1MdA_spocd1_plot
MetDiff_L1MdT_spocd1_plot
MetDiff_L1MdF_spocd1_plot
MetDiff_L1MdGf_spocd1_plot
MetDiff_IAP_spocd1_plot
MetDiff_IAPEy_spocd1_plot
MetDiff_IAPEz_spocd1_plot
MetDiff_MMERVK10C_spocd1_plot
dev.off()

                        
                        