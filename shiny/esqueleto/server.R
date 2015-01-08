# Esqueleto de aplicación con creación, edición, carga y descarga de data.frame
# Autor: Manuel Muñoz Márquez (manuel.munoz@uca.es)
# Licencia: GNU-GPL >= 3
# Proyecto: Proyecto R-UCA (http://knuth.uca.es/R)
#

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
      col.number <- isolate(ifelse(is.numeric(input$col.number), round(input$col.number), 0))
      new.name <- isolate(input$new.name)
      new.value <- isolate(input$new.value)
      col.type <- isolate(input$col.type)
      row.number <- isolate(ifelse(is.numeric(input$row.number), round(input$row.number), 0))
      if (action == 'Añadir columna' && new.name != '') {
          if (nrow(data) == 0) .data <- data.frame(numeric(0)) else .data <- data.frame(rep(NA, nrow(data)))
          colnames(.data) <- new.name
          .data[,1] <- switch(col.type,
              Numérico = as.numeric(.data[,1]),
              Factor = as.factor(.data[,1]),
              Carácter = as.character(.data[,1])
          )
          data <<- cbind(data, .data)
      }
      if (action == 'Añadir fila' && ncol(data) > 0) {
          if (ncol(data) > 0) data[nrow(data)+1,] <<- rep(NA, ncol(data))
      }
      if (action == 'Borrar columna' && col.number > 0 && col.number <= ncol(data)) data[,col.number] <<- NULL
      if (action == 'Borrar fila' && row.number > 0 && row.number <= nrow(data)) data <<- data[-row.number,]
      if (action == 'Cargar datos' && !isolate(is.null(input$input.file$datapath))) data <<- read.csv(isolate(input$input.file$datapath))
      if (action == 'Cargar ejemplos') data <<- read.csv(isolate(input$example.file))
      if (action == 'Editar casilla' && new.value != '' && row.number > 0 && row.number <= nrow(data) && col.number > 0 && col.number <= ncol(data)) {
          if (is.numeric(data[, col.number])) {
              new.value <- as.numeric(new.value)
              if (!is.na(new.value)) data[row.number, col.number] <<- new.value
          } else {
              if (is.factor(data[, col.number])) {
                  .factor <- data[, col.number]
                  .factor <- factor(.factor, levels = unique(c(levels(.factor), new.value)))
                  .factor[row.number] <- new.value
                  data[, col.number] <<- .factor
              } else data[row.number, col.number] <<- new.value
          }
      }
      if (action == 'Reiniciar') data <<- data.frame()
      if (action == 'Renombrar columna' && new.name != '' && col.number > 0 && col.number <= ncol(data)) colnames(data)[col.number] <<- new.name
      if (action == 'Renombrar fila' && new.name != '' && row.number > 0 && row.number <= nrow(data)) rownames(data)[row.number] <<- new.name
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
        write.csv(data, file = file, row.names = FALSE)
    }
    )
                          
})
