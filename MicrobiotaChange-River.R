install.packages(c("tidyverse", "ggalluvial"))
library(tidyverse)

# 微生物属と月の定義
set.seed(123)
genera <- c("Bacteroides", "Lactobacillus", "Akkermansia", "Prevotella", "Clostridium")
months <- paste0("Month_", 1:10)

# 架空データ作成（各月ごとに属の構成比が1になるよう正規化）
abund_list <- lapply(1:10, function(i) {
  rel_abund <- runif(length(genera), 0, 1)
  rel_abund <- rel_abund / sum(rel_abund)
  tibble(
    Month = months[i],
    Genus = genera,
    Abundance = rel_abund
  )
})

# データ結合・保存
abund_df <- bind_rows(abund_list)
write_csv(abund_df, "microbiome_abundance.csv")
library(ggalluvial)

# CSV読み込み
abund_df <- read_csv("microbiome_abundance.csv")

# 可視化用データ整形
abund_df$Month <- factor(abund_df$Month, levels = unique(abund_df$Month))

# プロット（ggalluvialによる川の流れ風）
ggplot(abund_df,
       aes(x = Month, stratum = Genus, alluvium = Genus,
           y = Abundance, fill = Genus, label = Genus)) +
  geom_flow(stat = "alluvium", lode.guidance = "frontback", color = "darkgray") +
  geom_stratum(width = 0.3, color = "black") +
  theme_minimal() +
  ylab("Relative Abundance") +
  xlab("Month") +
  ggtitle("Microbial Composition Transitions Over 10 Months") +
  theme(legend.position = "right",
        plot.title = element_text(hjust = 0.5))



library(tidyverse)

set.seed(42)

genera <- c("Bacteroides", "Lactobacillus", "Akkermansia", "Prevotella", "Clostridium")
months <- paste0("Month_", 1:10)

# 存在量（相対存在率）
abund_list <- lapply(1:10, function(i) {
  rel_abund <- runif(length(genera), 0, 1)
  rel_abund <- rel_abund / sum(rel_abund)
  
  # 架空の発現量（1〜10のスケール）
  expression <- runif(length(genera), 1, 10)
  
  tibble(
    Month = months[i],
    Genus = genera,
    Abundance = rel_abund,
    Expression = expression,
    Impact = rel_abund * expression  # 存在量 × 活性度
  )
})

df <- bind_rows(abund_list)
write_csv(df, "microbiome_abundance_expression.csv")
library(ggalluvial)

# データ読み込み
df <- read_csv("microbiome_abundance_expression.csv")
df$Month <- factor(df$Month, levels = unique(df$Month))

# 川の流れ図（Impactに基づく太さ）
ggplot(df,
       aes(x = Month, stratum = Genus, alluvium = Genus,
           y = Impact, fill = Genus, label = Genus)) +
  geom_stratum(width = 0.6, color = "black") +
  
  geom_flow(stat = "alluvium", lode.guidance = "frontback",
            alpha = 0.6,
            width = 0.2) +
  
  theme_minimal() +
  ylab("Functional Impact (Abundance × Expression)") +
  xlab("Month") +
  ggtitle("Microbial Transitions Over Time Adjusted by Expression") +
  theme(
    legend.position = "right",
    plot.title = element_text(hjust = 0.5)
  )