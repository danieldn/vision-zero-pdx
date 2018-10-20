#! /usr/bin/env Rscript

# Note: I run this on (Arch) Linux, So it installs from source, and there
# are quite a few Linux dependencies that need to be installed. If you run
# this on Windows or MacOS, it *should* install binary packages with all
# the dependencies bundled in.
install.packages(c(
  "tidyverse",
  "tmap",
  "sf",
  "sp"),
  quiet = TRUE)
