# マイクロバイオーム組成変化の可視化

このリポジトリでは,時系列でのマイクロバイオーム組成の変化を可視化するためのRコードを提供しています.複数の月にわたる細菌属の相対存在量の変化、および発現量を考慮した機能的インパクトの変化をアルヴィアルプロット(川の流れ図)で表現します.

## 特徴

- 複数時点でのマイクロバイオーム組成の変化を可視化
- 単純な存在量だけでなく、発現量を考慮した機能的インパクトの表現
- `ggalluvial`パッケージを用いた美しいアルヴィアルプロット（川の流れ図）
- 再現性のある架空データ生成コード

## 必要なパッケージ

- tidyverse
- ggalluvial

## 使用方法

### インストール

```r
install.packages(c("tidyverse", "ggalluvial"))
```

### データの生成と可視化

コードをクローンしてRスクリプトを実行するか,R内で以下を実行します：

```r
source("microbiome_analysis.R")
```

または,`microbiome_analysis.R`ファイル内のコードを段階的に実行することもできる.

## ファイル構成

- `microbiome_analysis.R`: メイン解析スクリプト
- `data/`: 生成されたCSVファイルが保存されるディレクトリ
  - `microbiome_abundance.csv`: 基本的な相対存在量データ
  - `microbiome_abundance_expression.csv`: 発現量と機能的インパクトを含むデータ
- `figures/`: 生成された可視化が保存されるディレクトリ
  - `composition_transitions.png`: 相対存在量の変化の可視化
  - `functional_impact.png`: 機能的インパクトの変化の可視化

## データ構造

### microbiome_abundance.csv

| Month | Genus | Abundance |
|-------|-------|-----------|
| Month_1 | Bacteroides | 0.245 |
| Month_1 | Lactobacillus | 0.134 |
| ... | ... | ... |

### microbiome_abundance_expression.csv

| Month | Genus | Abundance | Expression | Impact |
|-------|-------|-----------|------------|--------|
| Month_1 | Bacteroides | 0.245 | 6.78 | 1.661 |
| Month_1 | Lactobacillus | 0.134 | 4.23 | 0.567 |
| ... | ... | ... | ... | ... |

## 可視化の種類

1. **相対存在量の変化**: 各月での各属の存在量の変化を追跡
2. **機能的インパクトの変化**: 存在量と発現量を掛け合わせた影響度の変化を追跡

## カスタマイズ

以下の部分を変更することで、可視化をカスタマイズできます：

- `genera`変数: 対象とする細菌属のリスト
- `months`変数: 時間点のラベル
- `ggplot`関数内のパラメータ: 色、サイズ、透明度など

## ライセンス

MIT

## 参考文献

- [ggalluvial パッケージ](https://cran.r-project.org/web/packages/ggalluvial/vignettes/ggalluvial.html)
