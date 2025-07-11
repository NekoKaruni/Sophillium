library("tidyverse")
TOPIX <- read_csv("^tpx_y.csv")
## TOPIXの算出が始まり、切りのいい1970年から算出
# 年初始値と年末終値をベクトルにまとめる
TOPIX_OPEN <- TOPIX$Close[1:55]
TOPIX_CLOSE <- TOPIX$Close[2:56]
# 年次リターン（価格収益率）を計算
topix_return <- (TOPIX_CLOSE - TOPIX_OPEN) / TOPIX_OPEN

# 年度
years <- 1970:2024

# データフレーム化して見やすく表示
topix_df <- data.frame(
  Year = years,
  Open = TOPIX_OPEN,
  Close = TOPIX_CLOSE,
  Return = round(topix_return * 100, 2)  # パーセント表示
)

# 期待収益率（年平均リターン）
expected_return <- mean(topix_return)

# 結果の表示
print(topix_df)
cat("期待収益率（1970～2024年の平均）:", round(expected_return * 100, 2), "%\n")


library(tidyverse)

# coefを計算（Returnの最大値に合わせる）
coef <- max(topix_df$Close) / max(topix_df$Return)

# pivot_longerで長い形式に
TOPIX_df_long <- pivot_longer(topix_df, cols = c("Close", "Return"),
                              names_to = "項目", values_to = "値")

ggplot(TOPIX_df_long, aes(x = Year, y = ifelse(項目 == "Return", 値 * coef, 値), color = 項目)) +
  geom_line(size = 1) +
  scale_y_continuous(
    name = "TOPIX指数",
    sec.axis = sec_axis(~ . / coef, name = "値上がり率（%）")
  ) +
  scale_color_manual(values = c("Close" = "blue", "Return" = "red"),
                     labels = c("TOPIX指数", "値上がり率（%）")) +
  labs(
    title = "1970年~2024年 TOPIX指数と値上がり率",
    x = "年",
    color = ""
  ) +
  theme_minimal() +
  theme(legend.position = "top")
