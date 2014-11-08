# Esqueleto de aplicación con entrada, salida y modificación de data.frame
# Autor: Manuel Muñoz Márquez (manuel.munoz@uca.es)
# Licencia: GNU-GPL >= 3
# Proyecto: Proyecto R-UCA (http://knuth.uca.es/R)
#
library(shiny)
#library(orloca)

# Definición de la interfaz para la recogida de datos
shinyUI(pageWithSidebar(

  # Título de la aplicación
  headerPanel("Esqueleto de aplicación con entrada, salida y modificación de data.frame"),

  # Definición del panel lateral para la introducción de datos
  sidebarPanel(
    a('Menú Principal', href='http://knuth.uca.es/shiny/'),
       selectInput('action', 'Acción', c('Cargar datos', 'Borrar fila', 'Borrar columna', 'Reiniciar')),
       conditionalPanel(condition = "input.action == 'Cargar datos'", fileInput(inputId = "input.file", label = "Fichero:", accept =c("txt/csv", "text/comma-separated-values,text/plain", ".csv"))), 
       conditionalPanel(condition = "input.action == 'Borrar fila'", numericInput('row.del', 'Fila a borrar:', value = '')),
       conditionalPanel(condition = "input.action == 'Borrar columna'", numericInput('col.del', 'Columna a borrar:', value = '')),
    actionButton('goButton', 'Hacer')
  ),

  # Muestra los resultados
  mainPanel(
      tabsetPanel(
          tabPanel('Información',
                   p("Aplicación que permite la carga de un fichero csv con datos. Ha sido desarrollada para ser rehusada como esqueleto para nuevas aplicaciones."),
                   p("Para comenzar introduzca los valores de los parámetros, seleccione una acción y pulse en el botón \"Hacer\". Seleccione la pestaña que desea visualizar. Puede introducir nuevos valores y se actualizarán los resultados automáticamente."),
                   p("Realizado con shiny por", a("M. Muñoz-Márquez", href="mailto:manuel.munoz@uca.es"), "bajo licencia GNU-GPL como parte del", a("Proyecto R-UCA", href="http://knuth.uca.es/R"), "."),
                   hr(),
                   p("This application allows load a csv data file. It has been developed as starting point for new applications."),
                   p("To start input values for parameters, select an action, and press \"Hacer\". Select the tab to show. You can enter new values and the results will be updated automatically."),
                   p("Developed using shiny by", a("M. Muñoz-Márquez", href="mailto:manuel.munoz@uca.es"), "under GNU-GPL licence inside ", a("R-UCA Project", href="http://knuth.uca.es/R"), ".")
                   ),
          tabPanel('Gráfico',
                   plotOutput("Plot")
          ),
          tabPanel('Datos',
                   tableOutput('Data')
          ),
          tabPanel('Solución',
                   tableOutput('Solucion')
          )
       )      
    )
))
