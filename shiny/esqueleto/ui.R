## Esqueleto de aplicación con creación, edición, carga y descarga de un conjunto de datos (data.frame)
## Autor: Manuel Muñoz Márquez (manuel.munoz@uca.es)
## Licencia: GNU-GPL >= 3
## Proyecto: Proyecto R-UCA (http://knuth.uca.es/R)
## Versión on-line: http://knuth.uca.es/shiny/esqueleto/
## Repositorio: http://knuth.uca.es/repos/R-contribuciones/shiny/esqueleto/
##

## Load common functions
source('common.R')

## Load user function
source('user.R')

## Definición de la interfaz para la recogida de datos
shinyUI(pageWithSidebar(

    ## Título de la aplicación
    headerPanel(main.title(language = Language)),

    ## Definición del panel lateral para la introducción de datos
    sidebarPanel(
        selectInput('action', action.title(language = Language), choices = paste(actions)),
        conditionalPanel(condition = paste0("(input.action =='", actions['add_column'],"') || (input.action == '", actions['add_input'], "')"), selectInput('col.type', text['type'], paste(text[c('numeric', 'factor', 'character')]))),
        conditionalPanel(condition = paste0("(input.action == '", actions['drop_row'], "') || (input.action == '", actions['edit_cell'], "') || (input.action == '", actions['delete_cell'], "') || (input.action == '", actions['rename_row'], "')"), numericInput('row.number', text['row'], value = 0)),
        conditionalPanel(condition = paste0("(input.action == '", actions['delete_cell'], "') || (input.action == '", actions['drop_column'], "') || (input.action == '", actions['edit_cell'], "') || (input.action == '", actions['rename_column'], "') || (input.action == '", actions['transform_into_factor'], "')"), numericInput('col.number', text['column'], value = 0)),
        conditionalPanel(condition = paste0("(input.action == '", actions['add_column'], "') || (input.action == '", actions['rename_row'], "') || (input.action == '", actions['rename_column'], "')"), textInput('new.name', text['name'], value = '')),
        conditionalPanel(condition = paste0("input.action == '", actions['edit_cell'], "'"), textInput('new.value', text['value'], value = '')),
        conditionalPanel(condition = paste0("input.action == '", actions['download_data'], "'"), selectInput(inputId = "file.type", text['file.type'], choices = c('.csv', '.ods', '.xls'))),
        conditionalPanel(condition = paste0("input.action == '", actions['load_data'], "'"), fileInput(inputId = "input.file", label = text['file'], accept =c("txt/csv", "text/comma-separated-values,text/plain", ".csv"))),
        conditionalPanel(condition = paste0("input.action == '", actions['load_data'], "'"), selectInput(inputId = "input.sep", text['separator'], choices = c(',', ';', paste(text['space'])), selected = ',')),
        conditionalPanel(condition = paste0("input.action == '", actions['load_data'], "'"), selectInput(inputId = "input.dec", text['decimal'], choices = c('.', ','), selected = '.')),
        conditionalPanel(condition = paste0("input.action == '", actions['load_example'], "'"), selectInput('example.file', text['example'], examples.files(language = Language))),
        conditionalPanel(condition = paste0("input.action != '", actions['download_data'], "'"), actionButton('goButton', text['go'])),
        conditionalPanel(condition = paste0("input.action == '", actions['download_data'], "'"), downloadButton('downloadData', text['download_data'])),
        hr(),
        p(a(text['main_menu'], href='http://knuth.uca.es/shiny/')),
        p(a(other_language(language = Language), href=other_url(language = Language)))
    ),
    ## Muestra los resultados
    mainPanel(
        tabsetPanel(
            tabPanel(information.title(language = Language),
                     information.text(language = Language)
                     ),
            tabPanel(data.title(language = Language),
                     tableOutput('Data')
                     ),
            tabPanel(results.title(language = Language),
                     verbatimTextOutput('Results')
                     ),
            tabPanel(graphic.title(language = Language),
                     plotOutput("Graphic")
                     )
        )
    )
))
