# Esqueleto de aplicación con creación, edición, carga y descarga de un conjunto de datos (data.frame)
# Autor: Manuel Muñoz Márquez (manuel.munoz@uca.es)
# Licencia: GNU-GPL >= 3
# Proyecto: Proyecto R-UCA (http://knuth.uca.es/R)
#
# This file includes the definition of the user functions
# The user can defined here it's own funtion
# All required packages must be load here
library('lpSolve', quietly = TRUE)

### Definition of new data set, as data.frame, suitable for current model
new.data <- function() {
  data.frame(nombre = character(0), oferta = numeric(0), demanda = numeric(0), origen = numeric(0), destino = numeric(0), capacidad = numeric(0), coste = numeric(0))
}

### Main panel
main.title <- function(language = 'en') {
  switch(language,
         es = 'Esqueleto de aplicación con creación, edición, carga y descarga de un conjunto de datos (data.frame en R)',
         'Application skeleton for create, edit, load and download a data set (data.frame in R)'
         )
}

### Information tab definitions
# Title of the information tab
information.title <- function(language = 'en') {
  switch(language,
         es = 'Información',
         'Information')
}
# Text of the information tab
information.text <- function(language = 'en') {
  switch(language,
         es = HTML('<p align="justify">Aplicación que permite la creación, edición, carga y descarga de un fichero csv con datos. \
                   Ha sido desarrollada para ser reusada como esqueleto para nuevas aplicaciones.</p>\
                   <p align="justify">Para comenzar: seleccione una acción, introduzca los valores de los parámetros y pulse en el botón \"Hacer\". \
                   Seleccione la pestaña que desea visualizar.  \
                   Puede introducir nuevos valores y se actualizarán los resultados automáticamente.</p>\
                   <p align="justify">Realizado con shiny por <a href="mailto:manuel.munoz@uca.es">M. Muñoz-Márquez</a> bajo licencia GNU-GPL como parte del <a href="http://knuth.uca.es/R">Proyecto R-UCA</a>.</p>'),
         HTML('<p align="justify">This application allows create, edit, load and download a csv data file. \
              It has been developed as starting point for new applications.</p>\
              <p align="justify">To start: select an action, input values for parameters, and press \"Go\". \
              Select the tab to show. \
              You can enter new values and the results will be updated automatically.</p>\
              <p align="justify">Developed using shiny by <a href="mailto:manuel.munoz@uca.es">M. Muñoz-Márquez</a> under GNU-GPL licence inside <a href="http://knuth.uca.es/R">R-UCA Project</a>.')
  )
}

### Examples data set
examples.files <- function() {
  c('ejemplo1.csv', 'ejemplo2.csv')
}

### Data panel
# Title of data tab
data.title <- function(language = 'en') {
  switch(language,
         es = 'Datos',
         'Data'
         )
}

### Results panel
# Title of result tab
results.title <- function(language = 'en') {
  switch(language,
         es = 'Resultados',
         'Results'
  )
}
# Function that computes the results
results <- function(data) {
  # Compute the number of nodes
  n <- max(sum(!is.na(data$nombre)), max(data$origen, na.rm = TRUE), max(data$destino, na.rm = TRUE))
  # Compute the number of arc
  m <- sum(!is.na(data$origen) & !is.na(data$destino))
  # Return if no enough data available
  if (n == 0) return(invisible(NULL))
  # Compute the objective function coefficients
  cfo <- matrix(0, ncol = n, nrow = n)
  for (i in 1:nrow(data)) {
    if (!is.na(data$origen[i]) && !is.na(data$destino[i]) && !is.na(data$coste[i])) cfo[data$origen[i], data$destino[i]] <- data$coste[i]
    }
  cfo <- c(t(cfo))
  # Compute the right hand side
  demanda <- data$demanda
  demanda[is.na(demanda)] <- 0
  oferta <- data$oferta
  oferta[is.na(oferta)] <- 0
  cld <- demanda - oferta
  cld <- cld[1:n]
  cld[is.na(cld)] <- 0
  # Compute technology matrix coefficient
  A <- matrix(0, ncol = n^2, nrow = n)
  for (i in 1:nrow(data)) {
    if (!is.na(data$origen[i]) && !is.na(data$destino[i])) {
      A[data$destino[i], (data$origen[i] -1) * n + data$destino[i]] <- 1
      A[data$origen[i], (data$origen[i] -1) * n + data$destino[i]] <- -1
    }
  }
  # As lp does not allow to include limits over the value of variable
  # It is neccesary to put this limits as new restrictions
  clde <- rep(0, m)
  AE <- matrix(0, ncol = n^2, nrow = m)
  for (i in 1:nrow(data)) {
    if (!is.na(data$origen[i]) && !is.na(data$destino[i]) && !is.na(data$capacidad[i])) {
      AE[i, (data$origen[i] -1) * n + data$destino[i]] <- 1
      clde[i] <- data$capacidad[i]
    }
  }
  # Solve
  sol <- lp(direction = 'min', objective.in = cfo, const.mat = rbind(A, AE), const.rhs = c(cld, clde), const.dir = c(rep('>=', n), rep('<=', m)))
  # Output solution
  if (sol$status != 0) {
    cat('El problema es infactible.')
  } else {
    cat('El coste total es ', sol$objval, '.\n', sep = '')
    cat('La solución es:\n')
    sol <- sol$solution
    sol[sol == 0] <- NA
    sol <- t(matrix(sol, ncol = n))
    nombres <- data$nombre[1:n]
    nombres[is.na(nombres)] <- paste0('Nodo_', which(is.na(nombres)))
    colnames(sol) <- nombres
    rownames(sol) <- nombres
    print(sol, na.print = '')
  }
  # Return solution perphaps it is needed
  invisible(sol)
}

### Plot panel
# Title of plog tab
graphic.title <- function(language = 'en') {
  switch(language,
         es = 'Gráfico',
         'Graphic'
  )
}
# Function that plots the results
# This function must call results if it need it
graphic.plot <- function(data) {
  .plot <- FALSE
  if (nrow(data) > 0) for (i in 1:ncol(data)) .plot <- .plot || is.factor(data[,i]) || is.numeric(data[,i])
  if (.plot) {
    plot(data, main = '')
  } else plot.new()
}

