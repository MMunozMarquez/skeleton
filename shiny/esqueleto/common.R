# Esqueleto de aplicación con creación, edición, carga y descarga de data.frame
# Autor: Manuel Muñoz Márquez (manuel.munoz@uca.es)
# Licencia: GNU-GPL >= 3
# Proyecto: Proyecto R-UCA (http://knuth.uca.es/R)
#

# Initialize common data for ui and server
actions.es <- c(add_column = 'Añadir columna', add_row = 'Añadir fila', drop_column = 'Borrar columna', drop_row = 'Borrar fila', edit_cell = 'Editar casilla', load_data = 'Cargar datos', load_exaple = 'Cargar ejemplos', rename_column = 'Renombrar columna', rename_row = 'Renombrar fila', reset = 'Reiniciar')

actions.en <- c(add_column = 'Add column', add_row = 'Add row', drop_column = 'Drop column', drop_row = 'Drop row', edit_cell = 'Edit cell', load_data = 'Load data', load_exaple = 'Load examples', rename_column = 'Rename column', rename_row = 'Rename row', reset = 'Reset')

text.es <- c(action = 'Acción', character = 'Carácter', data = 'Datos', download_data = 'Descargar datos', information = 'Información', go = 'Hacer', factor = 'Factor', name = 'Nombre', numeric = 'Numérico', title = 'Esqueleto de aplicación con creación, edición, carga y descarga de data.frame', type = 'Tipo')
text.en <- c(action = 'Action', character = 'Character', data = 'Data', download_data = 'Download data', information = 'Information', go = 'Go', factor = 'Factor', name = 'Name', numeric = 'Numeric', title = 'Application skeleton for create, edit, load and download data.frame', type = 'Type')

actions <- actions.es
text <- text.es

actions <- actions.en
text <- text.en
