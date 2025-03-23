#!/bin/bash 
# run_check.sh 
# Run this script from the top-level lme4 source directory

# 1. Install all required dependencies
Rscript -e 'packages <- c("Rcpp", "Matrix", "lattice", "minqa", "nlminbwrap");
new_packages <- packages[!(packages %in% installed.packages()[,"Package"])];
if(length(new_packages)) {
  cat("Installing missing packages:", new_packages, "\n");
  install.packages(new_packages, repos="http://cran.r-project.org")
} else {
  cat("All required packages are already installed.\n")
}'

# 2. Build the source tarball 
echo "Building the source tarball..."
R CMD build .

# 3. Identify the newly built tarball 
TARBALL=$(ls -t lme4_*.tar.gz | head -n 1)
if [ -z "$TARBALL" ]; then
    echo "Error: No tarball found. Exiting."
    exit 1
fi
echo "Tarball created: $TARBALL"

# 4. Perform an R CMD check 
echo "Running R CMD check on $TARBALL..."
}.Rcheck"
if [ -d "$CHECK_DIR" ]; then
    echo "Contents of the check directory ($CHECK_DIR):"
    ls -lR "$CHECK_DIR"
else
    echo "No check directory found. The check may have failed to create it."
fi


