# Esqueleto de aplicación con creación, edición, carga y descarga de data.frame
# Autor: Manuel Muñoz Márquez (manuel.munoz@uca.es)
# Licencia: GNU-GPL >= 3
# Proyecto: Proyecto R-UCA (http://knuth.uca.es/R)
#
library(shiny)

# Initialize data
data <- data.frame()

# Define la lógica para el cálculo de los resultados
# Los datos de entrada se reciben en input
# Los resultados se guardan en output
shinyServer(function(input, output) {
  # renderPlot muestra la gráfica y la convierte en reactiva, es decir,
  dataInput <- reactive({
      input$goButton
      action <- isolate(input$action)
      if (action == 'Reiniciar') data <<- data.frame()
      if (action == 'Cargar datos' && !isolate(is.null(input$input.file$datapath))) data <<- read.csv(isolate(input$input.file$datapath))
      if (action == 'Añadir fila' && ncol(data) > 0) {
          if (ncol(data) > 0) data[nrow(data)+1,] <<- rep(NA, ncol(data))
      }
      if (action == 'Añadir columna' && isolate(input$col.name) != '') {
          if (nrow(data) == 0) .data <- data.frame(numeric(0)) else .data <- data.frame(rep(NA, nrow(data)))
          colnames(.data) <- isolate(eval(input$col.name))
          data <<- cbind(data, .data)
      }
      isolate(if (input$action == 'Borrar fila') {
        if (input$row.del > 0 && input$row.del <= nrow(data)) data[input$row.del,] <<- NULL
      })
      isolate(if (input$action == 'Borrar columna') {
        if (input$col.del > 0 && input$col.del <= ncol(data)) data[,input$col.del] <<- NULL
      })
      data
  })
  # se recalcula cuando cambian los parámetros de entrada
  output$Plot <- renderPlot({
      data <- dataInput()
      if (nrow(data) > 0) {
          plot(data, main = '')
      } else plot.new()
  })

# Output demand points
  output$Data <- renderTable({
      data <- dataInput()
  })
  
# Output solution
  output$Solution <- renderTable({
     data <- dataInput()
     if (nrow(data) > 0) {
         summary(data)
     }
  })

# Download
output$downloadData <- downloadHandler(
    filename = function() {
        paste('data-', Sys.Date(), '.csv', sep='')
    },
    content = function(file) {
        write.csv(data, file)
    }
    )
                          
})
