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
actions.es <- c(add_column = 'Añadir columna', add_row = 'Añadir fila',
                download_data = 'Descargar datos', drop_column = 'Borrar columna', drop_row = 'Borrar fila',
                edit_cell = 'Editar casilla', delete_cell = 'Vaciar casilla', load_data = 'Cargar datos', load_example = 'Cargar ejemplos',
                rename_column = 'Renombrar columna', rename_row = 'Renombrar fila', renumerate_row = 'Renumerar filas', reset = 'Reiniciar',
                transform_into_factor = 'Transformar en factor')
actions.en <- c(add_column = 'Add column', add_row = 'Add row',
                data.file.type = 'Data file type', download_data = 'Download data', drop_column = 'Drop column', drop_row = 'Drop row',
                edit_cell = 'Edit cell', delete_cell = 'Empty cell', load_data = 'Load data', load_example = 'Load examples',
                rename_column = 'Rename column', rename_row = 'Rename row', renumerate_row = 'Renumerate rows', reset = 'Reset',
                transform_into_factor = 'Transform into factor')




text.es <- c(character = 'Carácter', column = 'Columna',
             decimal = 'Punto decimal', download_data = 'Descargar datos',
             example = 'Ejemplo', file = 'Fichero', go = 'Hacer', factor = 'Factor', main_menu = 'Menú principal de ejemplos', name = 'Nombre',
             numeric = 'Numérico', other_language = 'Engish version', other_url = '../PLRCR/', row = 'Fila',
             space = '<Espacio>', separator = "Separador",
             type = 'Tipo', file.type = 'Tipo de fichero',
             value ='Valor')

text.en <- c(character = 'Character', column = 'Column',
             decimal = 'Decimal point', download_data = 'Download data',
             example = 'Example', file = 'File', go = 'Go', factor = 'Factor', main_menu = 'Main examples menu', name = 'Name',
             numeric = 'Numeric', other_language = 'Versión española', other_url = '../PLRCR/', row = 'Row',
             space = '<Space>', separator = 'Separator',
             type = 'Type', file.type = 'File type',
             value = 'Value')

actions <- actions.es
text <- text.es

# Set default language
Language <- 'es'
#Language <- 'en'

#actions <- actions.en
#information <- information.en
#text <- text.en
