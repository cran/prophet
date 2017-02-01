#!/usr/bin/env Rscript
args <- commandArgs(trailingOnly=TRUE)

src <- args[1]
dest <- args[2]
model_name <- args[3]

stc <- rstan::stanc(src)
stm <- rstan::stan_model(stanc_ret = stc, model_name = model_name)
stm.name <- paste(model_name, '.stanm', sep = '')
assign(stm.name, stm)

dir.create(dirname(dest), recursive = TRUE, showWarnings = FALSE)
expr <- paste('save(', stm.name, ', file = "', dest, '")', sep = '')
eval(parse(text = expr))
