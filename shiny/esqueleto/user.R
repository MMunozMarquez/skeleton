# Esqueleto de aplicación con creación, edición, carga y descarga de un conjunto de datos (data.frame)
# Autor: Manuel Muñoz Márquez (manuel.munoz@uca.es)
# Licencia: GNU-GPL >= 3
# Proyecto: Proyecto R-UCA (http://knuth.uca.es/R)
#
# This file includes the definition of the user functions
# The user can defined here it's own funtion
# All required packages must be load here

### Definition of new data set, as data.frame, suitable for current model
new.data <- function() {
  data.frame()
}

### Main panel
main.title <- function(language = 'en') {
  switch(language,
         es = 'Esqueleto de aplicación con creación, edición, carga y descarga de un conjunto de datos (data.frame en R)',
         'Application skeleton for create, edit, load and download a data set (data.frame in R)'
         )
}

### Menu panel
other_url <- function(language = 'en') {
  switch (language,
          es = '../skeleton/',
          '../esqueleto/'
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
examples.files <- function(language = 'en') {
    switch(language,
           es = c('ejemplo1.csv', 'ejemplo2.csv'),
           c('example1.csv', 'example2.csv')
           )
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
  if(nrow(data) > 0) summary(data)
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
  if (ncol(data) > 0) {
    columns <- sapply(data, function(x) {is.numeric(x) | is.factor(x)})
    if (sum(columns) > 1) {
      plot(data[, columns], main = '')
      } else plot.new()
  }
}

