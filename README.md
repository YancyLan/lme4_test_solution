# lme4_test_solution

This repository contains solutions to two tasks related to the lme4 package:

- **Easy Solution:** A shell script that, when run from the top-level lme4 source directory, installs missing dependencies, builds a source tarball, and runs `R CMD check` on it.
- **Medium Solution:** An R script that uses lme4's modular framework to implement a diagonal random effects covariance matrix. The solution optimizes the deviance function via `nloptwrap` and compares the result with a glmmTMB model using a diagonal random effects structure.
