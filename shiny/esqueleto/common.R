# Esqueleto de aplicación con creación, edición, carga y descarga de data.frame
# Autor: Manuel Muñoz Márquez (manuel.munoz@uca.es)
# Licencia: GNU-GPL >= 3
# Proyecto: Proyecto R-UCA (http://knuth.uca.es/R)
#

# Initialize common data for ui and server
actions.es <- c(add_column = 'Añadir columna', add_row = 'Añadir fila', drop_column = 'Borrar columna', drop_row = 'Borrar fila',
                edit_cell = 'Editar casilla', load_data = 'Cargar datos', load_example = 'Cargar ejemplos',
                rename_column = 'Renombrar columna', rename_row = 'Renombrar fila', reset = 'Reiniciar')
actions.en <- c(add_column = 'Add column', add_row = 'Add row', drop_column = 'Drop column', drop_row = 'Drop row',
                edit_cell = 'Edit cell', load_data = 'Load data', load_example = 'Load examples',
                rename_column = 'Rename column', rename_row = 'Rename row', reset = 'Reset')

information.es <- c('Aplicación que permite la creación, edición, carga y descarga de un fichero csv con datos. Ha sido desarrollada para ser rehusada como esqueleto para nuevas aplicaciones.',
   'Para comenzar introduzca los valores de los parámetros, seleccione una acción y pulse en el botón \"Hacer\". Seleccione la pestaña que desea visualizar.  Puede introducir nuevos valores y se actualizarán los resultados automáticamente.',
   'Realizado con shiny por',
   'bajo licencia GNU-GPL como parte del',
   'Proyecto R-UCA'
   )
information.en <- c('This application allows create, edit, load and download a csv data file. It has been developed as starting point for new applications.',
   'To start input values for parameters, select an action, and press \"Go\". Select the tab to show. You can enter new values and the results will be updated automatically.',
   'Developed using shiny by',
   'under GNU-GPL licence inside',
   'R-UCA Project'
   )


text.es <- c(action = 'Acción', character = 'Carácter', data = 'Datos', column = 'Columna', download_data = 'Descargar datos',
             example = 'Ejemplo', file = 'Fichero', graphic = 'Gráfico', information = 'Información', go = 'Hacer', factor = 'Factor', main_menu = 'Menú principal de ejemplos', name = 'Nombre',
             numeric = 'Numérico', other_language = 'Engish version', other_url = '../skeleton', results = 'Resultados', row = 'Fila', separator = "Separador",
             title = 'Esqueleto de aplicación con creación, edición, carga y descarga de data.frame', type = 'Tipo',
             value ='Valor')
text.en <- c(action = 'Action', character = 'Character', data = 'Data', column = 'Column', download_data = 'Download data',
             example = 'Example', file = 'File', graphic = 'Graphic', information = 'Information', go = 'Go', factor = 'Factor', main_menu = 'Main examples menu', name = 'Name',
             numeric = 'Numeric', other_language = 'Versión española', other_url = '../esqueleto', results = 'Results', row = 'Row', separator = "Separator",
             title = 'Application skeleton for create, edit, load and download data.frame', type = 'Type',
             value = 'Value')

actions <- actions.es
information <- information.es
text <- text.es

#actions <- actions.en
#information <- information.en
#text <- text.en
