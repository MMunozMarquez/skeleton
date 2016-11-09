# Esqueleto de aplicación con creación, edición, carga y descarga de un conjunto de datos (data.frame)
# Autor: Manuel Muñoz Márquez (manuel.munoz@uca.es)
# Licencia: GNU-GPL >= 3
# Proyecto: Proyecto R-UCA (http://knuth.uca.es/R)
#
#
# This file includes common functions of ui and server
# Don't edit this file unless you know what are you doing

### Actions definition
# Title of action menu
action.title <- function(language = 'en') {
  switch(language,
         es = 'Acción',
         'Action')
}
# Initialize common data for ui and server
actions.es <- c(add_column = 'Añadir columna', add_row = 'Añadir fila', drop_column = 'Borrar columna', drop_row = 'Borrar fila',
                edit_cell = 'Editar casilla', delete_cell = 'Vaciar casilla', load_data = 'Cargar datos', load_example = 'Cargar ejemplos',
                rename_column = 'Renombrar columna', rename_row = 'Renombrar fila', renumerate_row = 'Renumerar filas', reset = 'Reiniciar')
actions.en <- c(add_column = 'Add column', add_row = 'Add row', drop_column = 'Drop column', drop_row = 'Drop row',
                edit_cell = 'Edit cell', delete_cell = 'Empty cell', load_data = 'Load data', load_example = 'Load examples',
                rename_column = 'Rename column', rename_row = 'Rename row', renumerate_row = 'Renumerate rows', reset = 'Reset')

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

text.es <- c(character = 'Carácter', column = 'Columna',
             decimal = 'Punto decimal', data = 'Datos', download_data = 'Descargar datos',
             example = 'Ejemplo', file = 'Fichero', graphic = 'Gráfico', information = 'Información', go = 'Hacer', factor = 'Factor', main_menu = 'Menú principal de ejemplos', name = 'Nombre',
             numeric = 'Numérico', other_language = 'Engish version', other_url = '../skeleton', results = 'Resultados', row = 'Fila',
             space = '<Espacio>', separator = "Separador",
             title = 'Esqueleto de aplicación con creación, edición, carga y descarga de un conjunto de datos (data.frame en R)', type = 'Tipo',
             value ='Valor')
text.en <- c(character = 'Character', column = 'Column',
             decimal = 'Decimal point', data = 'Data', download_data = 'Download data',
             example = 'Example', file = 'File', graphic = 'Graphic', information = 'Information', go = 'Go', factor = 'Factor', main_menu = 'Main examples menu', name = 'Name',
             numeric = 'Numeric', other_language = 'Versión española', other_url = '../esqueleto', results = 'Results', row = 'Row',
             space = '<Space>', separator = 'Separator',
             title = 'Application skeleton for create, edit, load and download a data set (data.frame in R)', type = 'Type',
             value = 'Value')

actions <- actions.es
information <- information.es
text <- text.es

# Set default language
Language <- 'es'
#Language <- 'en'

#actions <- actions.en
#information <- information.en
#text <- text.en
