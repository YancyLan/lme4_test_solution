library(lme4)
library(nloptr)
library(glmmTMB)

data(sleepstudy)
lf <- lFormula(Reaction ~ Days + (Days | Subject), data = sleepstudy,
               control = lmerControl(check.nobs.vs.nRE = "ignore"))
low <- lf$reTrms$lower
devfun <- mkLmerDevfun(lf$fr, lf$X, lf$reTrms)

diag_wrapper <- function(sd) {
  theta <- numeric(length(low))
  theta[which(low == 0)] <- sd
  devfun(theta)
}

n_diag <- sum(low == 0)
opt_res <- nloptwrap(
  par = rep(0, n_diag),
  fn = diag_wrapper,
  lower = rep(0, n_diag),
  upper = rep(Inf, n_diag),
  control = list(algorithm = "NLOPT_LN_BOBYQA", maxeval = 1000)
)

fit <- mkMerMod(rho = environment(devfun), opt = opt_res, reTrms = lf$reTrms, fr = lf$fr, mc = match.call())
print(fit)

tmb_fit <- glmmTMB(Reaction ~ Days + diag(Days | Subject), data = sleepstudy, REML = TRUE)
print(summary(tmb_fit))
