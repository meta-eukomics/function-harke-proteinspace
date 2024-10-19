library("ggplot2")
library("patchwork")
library("RColorBrewer")

###-------- load data --------###
df <- read.csv("data/eukMetaInt_proteinNum.csv", header=TRUE)

###-------- subset by grouping --------###
dfa <- subset(df, sampe=='A')
dfb <- subset(df, sampe=='B')
dfc <- subset(df, sampe=='C')

###-------- plot by sample --------###
a <- ggplot(dfa, aes(x=assembly, y=proteins)) + 
  geom_bar(stat="identity", color="black", fill="gray91", position=position_dodge())+
  ylab('# predicted proteins')+
  scale_y_continuous(expand = c(0,0), limits = c(0,1.5e+06))+
  theme_classic ()+
  #ggtitle("HS039 Separate pipelines")+
  theme(text = element_text(size=12))+
  theme(axis.title.x = element_blank())+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

b <- ggplot(dfb, aes(x=assembly, y=proteins)) + 
  geom_bar(stat="identity", color="black", fill="gray91", position=position_dodge())+
  ylab('# predicted proteins')+
  scale_y_continuous(expand = c(0,0), limits = c(0,1.5e+06))+
  theme_classic ()+
  #ggtitle("CAGs Uniform pipeline")+
  theme(text = element_text(size=12))+
  theme(axis.title.x = element_blank())+
  theme(axis.title.y = element_blank())+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

c <- ggplot(dfc, aes(x=assembly, y=proteins)) + 
  geom_bar(stat="identity", color="black", fill="gray91", position=position_dodge())+
  ylab('# predicted proteins')+
  scale_y_continuous(expand = c(0,0), limits = c(0,1.7e+07))+
  theme_classic ()+
  #ggtitle("MAD/High CAG Uniform pipeline")+
  theme(text = element_text(size=12))+
  theme(axis.title.x = element_blank())+
  theme(axis.title.y = element_blank())+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

a + b + c + 
  plot_layout(ncol = 3, widths = c(0.9,2.2,0.2))

###-------- plot by assembly --------###
# set colors
colourCount = length(unique(dfa$assembler))
getPalette = colorRampPalette(brewer.pal(9, "Set1"))

d <- ggplot(dfa, aes(x=assembly, y=proteins, fill = assembler)) + 
  geom_bar(stat="identity", color="black", position=position_dodge())+
  ylab('# predicted proteins')+
  theme_classic ()+
  ggtitle("Combined vs Single Assembly")+
  scale_fill_manual(values = getPalette(colourCount)) +
  theme(text = element_text(size=12))+
  theme(axis.title.x = element_blank())+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  facet_grid(. ~ assembler2, scales = "free", space = "free")

###-------- plot by ribodepletion --------###
e <- ggplot(dfa, aes(x=assembly, y=proteins, fill = assembler)) + 
  geom_bar(stat="identity", color="black", position=position_dodge())+
  ylab('# predicted proteins')+
  theme_classic ()+
    ggtitle("Was ribodepletion done?")+
  scale_fill_manual(values = getPalette(colourCount)) +
  theme(text = element_text(size=12))+
  theme(axis.title.x = element_blank())+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  facet_grid(. ~ ribodeplete, scales = "free", space = "free")

###-------- plot by dereplication --------###
f <- ggplot(dfa, aes(x=assembly, y=proteins, fill = assembler)) + 
  geom_bar(stat="identity", color="black", position=position_dodge())+
  ylab('# predicted proteins')+
  theme_classic ()+
  ggtitle("Was dereplication done?")+
  scale_fill_manual(values = getPalette(colourCount)) +
  theme(text = element_text(size=12))+
  theme(axis.title.x = element_blank())+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  facet_grid(. ~ dereplicate, scales = "free", space = "free")

###-------- plot by protein predictor --------###
g <- ggplot(dfa, aes(x=assembly, y=proteins, fill = assembler)) + 
  geom_bar(stat="identity", color="black", position=position_dodge())+
  ylab('# predicted proteins')+
  theme_classic ()+
  ggtitle("What protein predictor?")+
  scale_fill_manual(values = getPalette(colourCount)) +
  theme(text = element_text(size=12))+
  theme(axis.title.x = element_blank())+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  facet_grid(. ~ proteinpredict, scales = "free", space = "free")

d + e + f + g
+  plot_layout(ncol = 2)
