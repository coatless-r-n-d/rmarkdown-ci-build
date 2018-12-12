#########################################
# test_rmd_render.R
# Compile a students' Rmd file on travis
# Version 0.0.1
#########################################
# James J Balamuta
# balamut2@illinois.edu
#
# Note: Code found here is based off of
# Carl Boettiger's approach.
#########################################


# Obtain the names of all files that have an Rmd extension
Rmds = list.files(pattern = ".Rmd$", recursive = TRUE)

# Try to knit those files
knit_files = sapply(Rmds,
                    function(x) {
                      message("Attempting to compile", x, "...")
                      tryCatch({
                        rmarkdown::render(x)
                        TRUE
                      },
                      error = function(e) {
                        FALSE
                      })
                    })

# Report bad files to students... Otherwise, exit quietly.
if (any(!knit_files)) {

  cat("The following files did not knit properly:\n\n")
  cat(paste("  *", names(knit_files)[!knit_files], collapse = "\n"), "\n\n")
  cat("Please fix the error and then submit again.\n")

  # Error
  q(save = "no", status = 1, runLast = FALSE)
}

 # Whew, we're alive.
cat("All Rmd files were able to be knit.\n")
