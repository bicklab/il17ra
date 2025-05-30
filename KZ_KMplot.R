library(survival)
library(survminer)
library(tidyr)
library(dplyr)

summary(data_test$surv_CVD)
data_test <- filter(data_test, data_test$surv_CVD >0)

data_jak2_pos <- data_test %>%
  filter(jak2 == 1)

surv_obj <- Surv(time = data_jak2_pos$surv_CVD, event = data_jak2_pos$CVD)

km_fit <- survfit(surv_obj ~ il17ra_333, data = data_jak2_pos)


p <- ggsurvplot(
  km_fit,
  data = data_jak2_pos,
  risk.table = TRUE,
  pval = TRUE,
  conf.int = TRUE,
  xlab = "Time (Years)",
  ylab = "Survival Probability",
  legend.title = "IL17RA Group (JAK2+ only)",
  palette = RColorBrewer::brewer.pal(3, "Set1"),
  surv.median.line = "hv",
  ylim = c(0.8,1)
)
p

sprintf("Log-rank test p-value: %.4g", p_val)


surv_obj <- Surv(time = data_jak2_pos$surv_CVD, event = data_jak2_pos$CVD)
logrank_test <- survdiff(surv_obj ~ il17ra_333, data = data_jak2_pos)
p_val <- 1 - pchisq(logrank_test$chisq, df = length(logrank_test$n) - 1)
p_val

install.packages("sjPlot")
library(sjPlot)

save_plot("kmplot_jak2_il17R_r1.svg", fig = p, width=25, height=25)
