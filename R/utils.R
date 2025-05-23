# Functions for Internal Use
`%nin%` <- Negate(`%in%`)

check_model <- function(model,
                        classes = "mHMM",
                        fns = classes){
  cls_names <- cli::cli_vec(paste0("mHMMbayes::", classes),
                            style = list("vec-last" = ", or ", "vec-sep2" = " or "))
  fns_names <- cli::cli_vec(paste0("mHMMbayes::", fns),
                            style = list("vec-last" = ", or ", "vec-sep2" = " or "))
  if (is.null(model)) {
    cli::cli_abort(
      c("x" = "The argument {.var model} has not been specified.", "i" = "Please specify an object of class {.cls {cls_names}}, obtained using {.fn {fns_names}}.")
    )
  }
  if (!inherits(model, classes)) {
    cli::cli_abort(
      c(
        "Argument {.var model} should be an object of class {.cls {cls_names}}.",
        "x" = "You have provided an object of class {.cls {class(model)}}.",
        "i" = "Use the function {.fn {fns_names}} to obtain an object of class {.cls {cls_names}}."
      )
    )
  }
}

check_vrb <- function(model,
                      vrb,
                      vctr = TRUE){
  if (is.null(vrb)) {
    vrb <- model$input$dep_labels[1]
    cli::cli_inform(
      c(
        "You did not provide a string to {.var vrb}, specifying the dependent variable to plot.",
        "i" = "The first variable in the dataset, {.val {vrb}}, will be used."
      )
    )
  } else if (!is.character(vrb)) {
    vrb <- model$input$dep_labels[1]
    cli::cli_inform(
      c(
        "{.var vrb} needs a character string, specifying the dependent variable to plot.",
        "x" = "You specified an object of class {.cls {class(vrb)}}.",
        "i" = "The first variable in the dataset,{.val{vrb}}, will be used."
      )
    )
  } else if (!vctr & length(vrb) > 1) {
    cli::cli_inform(
      c(
        "{.var vrb} needs a character string of length 1, specifying the dependent variable to plot.",
        "x" = "You specified an object with length {length(vrb)}.",
        "i" = "The first specified variable ({.val vrb[1]}) will be plotted."
      )
    )
    vrb <- vrb[1]
  }
  if (vrb %nin% model$input$dep_labels) {
    dep_labs <- cli::cli_vec(model$input$dep_labels,
                             style = list("vec-last" = ", or ", "vec-sep2" = " or "))
    cli::cli_abort(
      c(
        "Argument {.var vrb} should be a character string corresponding to a variable name in the model.",
        "x" = "{.val {vrb}} does not correspond to a variable name used in the model.",
        "i" = "Possible values of {.var vrb} for your model are: {.val {dep_labs}}."
      )
    )
  }
  return(vrb)
}

#' Pipe operator
#'
#' See \code{magrittr::\link[magrittr:pipe]{\%>\%}} for details.
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @usage lhs \%>\% rhs
#' @param lhs A value or the magrittr placeholder.
#' @param rhs A function call using the magrittr semantics.
#' @return The result of calling `rhs(lhs)`.
NULL
