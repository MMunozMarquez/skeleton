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

text.es <- c(action = 'Acción', character = 'Carácter', data = 'Datos', column = 'Columna', download_data = 'Descargar datos',
             example = 'Ejemplo', file = 'Fichero', graphic = 'Gráfico', information = 'Información', go = 'Hacer', factor = 'Factor', name = 'Nombre',
             numeric = 'Numérico', results = 'Resultados', row = 'Fila', separator = "Separador",
             title = 'Esqueleto de aplicación con creación, edición, carga y descarga de data.frame', type = 'Tipo',
             value ='Valor')
text.en <- c(action = 'Action', character = 'Character', data = 'Data', column = 'Column', download_data = 'Download data',
             example = 'Example', file = 'File', graphic = 'Graphic', information = 'Information', go = 'Go', factor = 'Factor', name = 'Name',
             numeric = 'Numeric', results = 'Results', row = 'Row', separator = "Separator",
             title = 'Application skeleton for create, edit, load and download data.frame', type = 'Type',
             value = 'Value')

actions <- actions.es
text <- text.es

#actions <- actions.en
#text <- text.en
