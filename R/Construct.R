# Initiate the class ============================
#' An S4 class to represent multiple sets.
#'
#' @slot sets A \code{list} object containing vectors in the same type.
#' @slot names The names of the \code{sets} if it has names. If the \code{list}
#'   doesn't have names, the sets will be named as "Set_1", "Set_2", "Set_3" and
#'   so on.
setClass("Venn",
         slots = list(sets = "ANY", names = "ANY")
)


# New method to create an instance ==============
setGeneric("Venn", function(sets) {
  standardGeneric("Venn")
}
)

#' @export
#' @importFrom methods new
#' @rdname Venn
setMethod("Venn", c(sets = "ANY"),
          function(sets) {

            if (!is.list(sets)) {
              stop("Data should be given in a list.")
            }

            if (sum(sapply(sets, is.null) == TRUE) >= 1) {
              sets = sets[!(sapply(sets, is.null))]
            }

            if (length(sets) <= 1) {
              stop("The list should contain at least 2 vectors.")
            }

            if (length(unique(sapply(sets, class))) != 1) {
              stop("Vectors should be in the same class.")
            }

            if (!(sapply(sets, class)[1] %in% c("integer", "numeric", "character"))) {
              stop("The list must contain only integers, numerics or characters.")
            }

            venn = new(Class = "Venn", sets = sets)

            if (is.null(names(venn@sets))) {
              names(venn@sets) = paste("Set", seq_len(length(venn@sets)), sep = "_")
            }

            venn@names = names(venn@sets)

            venn@sets = lapply(venn@sets, unique)  # Sets shouldn't include duplicates.

            venn
          }
)
