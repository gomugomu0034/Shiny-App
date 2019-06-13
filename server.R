#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# SHiny server function designs two different model based on mtcars dataset
# model 1 (a linear model) fits mileage with horsepower, 
# model 2 (a linear model) fits mileage with horsepower, cylinder numbers and transmission mode
# These models are used to predict mileage for the desired input
# 
shinyServer(function(input, output) {
        
   model1 <- lm(mpg ~ hp, data = mtcars)
   model2 <- lm(mpg ~ hp + factor(cyl) + factor(am), data = mtcars)
   
   model1pred <- reactive({
           hpInput <- input$hp
           predict(model1, newdata = data.frame(hp = hpInput))
   })
   model2pred <- reactive({
                hpInput <- input$hp
                if(input$am == "Automatic") {amInput <- 1}
                else {amInput <- 0}
                cylInput <- input$cyl
                predict(model2, newdata = data.frame(hp = hpInput, cyl = cylInput, am = amInput))
           })
   
  output$Plot1 <- renderPlot({
    
    # renderplot generates the plot which will be displayed in the main panel of the application
          # on the x axis of graph data on horsepower is represented
          # on the y axis of the graph, data on mileage is represented
          # There are two lines in the graph corresponding to respective linear models they represent
         
   hpInput <- input$hp
   plot(mtcars$hp, mtcars$mpg, xlab = "Horsepower", ylab = "Miles per Gallon",
        pch = 16, xlim = c(50,350), ylim = c(10,35))
   abline(model1,col = "red", lwd = 2)
   if(input$showModel2){
           abline(model2, col = "blue", lwd = 2)
   }
   legend(250,35
          , c("Model 1 Prediction", "Model 2 Prediction"), 
          pch = 16, col = c("red", "blue"), bty = "n", cex = 1.2)
   points(hpInput, model1pred(), col = "red", pch = 20, cex = 2)
   points(hpInput, model2pred(), col = "blue", pch = 20, cex = 2)
  })
  
  # Text output is rendered here
  # takes the prediction output from bpth models and pass them to the user interface as text
  output$pred1 <- renderText({model1pred()})
  output$pred2 <- renderText({model2pred()})
  
})
