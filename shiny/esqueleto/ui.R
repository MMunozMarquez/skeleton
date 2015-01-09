# Esqueleto de aplicación con creación, edición, carga y descarga de data.frame
# Autor: Manuel Muñoz Márquez (manuel.munoz@uca.es)
# Licencia: GNU-GPL >= 3
# Proyecto: Proyecto R-UCA (http://knuth.uca.es/R)
#

# Initialize data
source('common.R')
    
# Definición de la interfaz para la recogida de datos
shinyUI(pageWithSidebar(

  # Título de la aplicación
  headerPanel(text['title']),

  # Definición del panel lateral para la introducción de datos
  sidebarPanel(
    selectInput('action', text['action'], choices = paste(actions), selected = actions['load_data']),
    conditionalPanel(condition = paste0("input.action =='", actions['add_column'],"'"), selectInput('col.type', text['type'], c(text['numeric'], text['factor'], text['character']))),
    conditionalPanel(condition = paste0("(input.action == '", actions['drop_row'], "') || (input.action == '", actions['edit_cell'], "') || (input.action == '", actions['rename_row'], "')"), numericInput('row.number', text['row'], value = 0)),
    conditionalPanel(condition = paste0("(input.action == '", actions['drop_column'], "') || (input.action == '", actions['edit_cell'], "') || (input.action == '", actions['rename_column'], "')"), numericInput('col.number', text['column'], value = 0)),
    conditionalPanel(condition = paste0("(input.action == '", actions['add_column'], "') || (input.action == 'Renombrar fila') || (input.action == 'Renombrar columna')"), textInput('new.name', text['name'], value = '')),
    conditionalPanel(condition = "input.action == 'Editar casilla'", textInput('new.value', 'Valor:', value = '')),
    conditionalPanel(condition = "input.action == 'Cargar datos'", fileInput(inputId = "input.file", label = "Fichero:", accept =c("txt/csv", "text/comma-separated-values,text/plain", ".csv"))),
    conditionalPanel(condition = paste0("input.action == '", actions['load_example'], "'"), selectInput('example.file', 'Ejemplo:', c('ejemplo1.csv', 'ejemplo2.csv'))),
    actionButton('goButton', text['go']),
    hr(),
    downloadButton('downloadData', text['download_data'])
  ),

  # Muestra los resultados
  mainPanel(
      tabsetPanel(
          tabPanel(text['information'],
                   p("Aplicación que permite la carga de un fichero csv con datos. Ha sido desarrollada para ser rehusada como esqueleto para nuevas aplicaciones."),
                   p("Para comenzar introduzca los valores de los parámetros, seleccione una acción y pulse en el botón \"Hacer\". Seleccione la pestaña que desea visualizar. Puede introducir nuevos valores y se actualizarán los resultados automáticamente."),
                   p("Realizado con shiny por", a("M. Muñoz-Márquez", href="mailto:manuel.munoz@uca.es"), "bajo licencia GNU-GPL como parte del", a("Proyecto R-UCA", href="http://knuth.uca.es/R"), "."),
                   p(a('Menú principal de ejemplos', href='http://knuth.uca.es/shiny/')),
                   hr(),
                   p("This application allows load a csv data file. It has been developed as starting point for new applications."),
                   p("To start input values for parameters, select an action, and press \"Hacer\". Select the tab to show. You can enter new values and the results will be updated automatically."),
                   p("Developed using shiny by", a("M. Muñoz-Márquez", href="mailto:manuel.munoz@uca.es"), "under GNU-GPL licence inside ", a("R-UCA Project", href="http://knuth.uca.es/R"), "."),
                   p(a('Main examples menu', href='http://knuth.uca.es/shiny/'))
                   ),
          tabPanel(text['data'],
                   tableOutput('Data')
          ),
          tabPanel('Gráfico',
                   plotOutput("Plot")
          ),
          tabPanel('Solución',
                   tableOutput('Solution')
          )
       )      
    )
))
