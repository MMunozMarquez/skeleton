# Esqueleto de aplicación con creación, edición, carga y descarga de un conjunto de datos (data.frame)
# Autor: Manuel Muñoz Márquez (manuel.munoz@uca.es)
# Licencia: GNU-GPL >= 3
# Proyecto: Proyecto R-UCA (http://knuth.uca.es/R)
#
# This file includes the definition of the user functions
# The user can defined here it's own funtion
# All required packages must be load here
library('igraph', quietly = TRUE)
library('lpSolve', quietly = TRUE)

### Definition of new data set, as data.frame, suitable for current model
new.data <- function() {
  data.frame(nombre = character(0), oferta = numeric(0), demanda = numeric(0), origen = numeric(0), destino = numeric(0), capacidad = numeric(0), coste = numeric(0))
}

### Main panel
main.title <- function(language = 'en') {
  switch(language,
         es = 'Cálculo del flujo a coste mínimo entre las fuentes y los sumideros (Aplicación derivada de la aplicación esqueleto)',
         'Look for the minimum cost flow from origins to destinations (Application developed from skeleton application)'
         )
}

### Menu panel
other_url <- function(language = 'en') {
  switch (language,
    es = '../min_flow_cost',
    '../flujo_coste_minimo'
  )
}
other_language <- function(language = 'en') {
  switch (language,
          es = 'English version',
          'Versión española'
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
         es = HTML('<p align="justify">El problema de flujo a coste mínimo consiste en encontrar la forma de transportar un producto desde unos nodos origen conocidos como fuentes a los nodos destino conocidos como sumidero. \
                  De cada fuente se conoce su oferta y de cada sumidero su demanda. \
                  Cada envío lleva asociado un coste unitario y cada enlace entre dos nodos tiene una capacidad máxima que no puede sobrepasarse.</p>\
                  <p align="justify">Esta aplicación ha sido desarrollada a partir de la aplicación <a href="http://knuth.uca.es/shiny/esqueleto/">esqueleto</a> con fines didácticos. \
                  La aplicación esqueleto ha sido desarrollada de forma que la creación de aplicaciones como ésta a partir de ella no requiere conocimientos de shiny ni de html.</p>\
                  <p align="justify">Está disponible bajo petición un <b>curso gratuito</b> donde se explica de forma detallada la forma de realizar este proceso.</p>\
                   <p align="justify">Para comenzar: seleccione una acción, introduzca los valores de los parámetros y pulse en el botón \"Hacer\". \
                   Seleccione la pestaña que desea visualizar.  \
                   Puede introducir nuevos valores y se actualizarán los resultados automáticamente.</p>\
                   <p align="justify">Realizado con shiny por <a href="mailto:manuel.munoz@uca.es">M. Muñoz-Márquez</a> bajo licencia GNU-GPL como parte del <a href="http://knuth.uca.es/R">Proyecto R-UCA</a>.</p>'),
         HTML('<p align="justify">The problem of flow of a minimum cost is to find the way of transport of a product from the origin nodes, sources nodes, to the destination nodes, sink nodes. \
              Each pair origin destinationship has associated an unitary cost and each link between two nodes has a maximum capacity that can not be exceeded.</p>\
              <p aling="justify">This application has been developed from the application <a href="http://knuth.uca.es/shiny/skeleton/">skeleton</a> for didactic purposes. \
              The skeleton application has been developed so that the creation of applications like this one does not require knowledge of shiny or html.</p>\
              <p aling="justify">A free <b>course</b> is available on request, which explains in detail how to do this process.</p>\
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
    return(invisible(NULL))
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
    # Compute the number of nodes
    n <- max(sum(!is.na(data$nombre)), max(data$origen, na.rm = TRUE), max(data$destino, na.rm = TRUE))
    if (n > 0) {
        # Solve
        sol <- results(data)
        if (is.null(sol)) {
            plot.new()
        } else {
            # Save solution into data
            data$vcolor <- 'white'
            data$vshape <- 'circle'
            data$color <- 'black'
            data$x <- 0
            for (i in 1:nrow(data)) {
                if (!is.na(sol[data$origen[i], data$destino[i]])) {
                    data$x[i] <- sol[data$origen[i], data$destino[i]]
                    data$color[i] <- ifelse(round(data$x[i], 0) == data$capacidad[i], 'red', 'green')
                    }
                if (!is.na(data$oferta[i])) {
                    data$vcolor[i] <- 'yellow'
                    data$vshape[i] <- 'square'
                    }
                if (!is.na(data$demanda[i])) {
                    data$vcolor[i] <- 'orange'
                    data$vshape[i] <- 'square'
                    }
            }
            print(data)
            # Build igraph
            n <- nrow(sol)
            g <- graph_from_edgelist(cbind(data$origen, data$destino))
            # Set up node names
            nombres <- data$nombre[1:n]
            nombres[is.na(nombres)] <- paste0('Nodo_', which(is.na(nombres)))
            #g <- set_vertex_attr(graph = g, name = 'label', value = paste0(nombres, '\n(', data$oferta[1:n], '/', data$demanda[1:n], ')'))
            g <- set_vertex_attr(graph = g, name = 'label', value = nombres)
            g <- set_vertex_attr(graph = g, name = 'color', value = data$vcolor[1:n])
            g <- set_vertex_attr(graph = g, name = 'shape', value = data$vshape[1:n])
            # Show solution in arcs using color code
            g <- set_edge_attr(graph = g, name = 'label', value = paste(round(data$x, 0), '/', data$capacidad))           
            g <- set_edge_attr(graph = g, name = 'color', value = data$color)
            if (Sys.getenv('SHINY_PORT') == "") tkplot(g)
            plot(g)
        }
    } else {
        plot.new()
    }
}
