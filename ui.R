#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# This app predicts the mileage per gallon of a car based on its 
# cylinder qunatity and its transmission mode
shinyUI(fluidPage(
  
  # Title for the application
  titlePanel("Predicting Mileage per gallon from Horsepower, Number of Cylinders and Transmission Mode"),
  
  # Sidebar will consist of all the input options
  # Slider input fr giving the value of horsepower
  # radio choice input for number of cylinders and transmission mode
  # checkbox input to show/hide model 2 prediction model from the output
  sidebarLayout(
    sidebarPanel( h3("Input your desired specifications here"),
       sliderInput("hp",
                   "Desired Horsepower",
                   min = 50,
                   max = 500,
                   value = 150),
       radioButtons("cyl", "Desired Number of Cylinders",c(4,6,8), inline = TRUE),
       radioButtons("am", "Desired Transmission", c("Automatic", "Manual"), inline = TRUE),
       checkboxInput("showModel2", "Show Model 2 Line", value = TRUE),
       submitButton(text = "Submit"),
       h5("NOTE: Input the horsepower of your car with slider input option above. 
          Along with it input the number of cylinders and gear transmission mode of your car."),
             h5("1. This app will predict the mileage per gallon of your car based on the specifications."),
          h5("2. Plot on the side shows the variation of mileage per gallon with horsepower."),
        h5("3. Below the plot predicted values of mileage per gallon are mentioned based on our 2 models.")
    ),
    
    # Output numbers and plots will be displayed in main panel
    # Plot output shows trends in mileage with horsepower
    # There are lines corresponding to model 1 and model 2 in the graph
    # Graph also shows predicted values for the mileage
    # Same predicted values are displayed as text output below the graph
    mainPanel(
        h5("Model 1: Linear model with mileage per gallon as the outcome and horsepower as the predictor"),
        h5("Model 2: Linear model with mileage per gallon as the outcome and horsepower, number of cylinders and transmission mode as the predictors"),
       plotOutput("Plot1"),
       h3("Predicted Miles per gallon from Model 1"),
       textOutput("pred1"),
       h3("Predicted Miles per gallon from Model 2"),
       textOutput("pred2")
    )
  )
))
