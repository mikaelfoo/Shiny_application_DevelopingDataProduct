#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

'
1)Some form of input (widget: textbox, radio button, checkbox, ...)
2)Some operation on the ui input in sever.R
3)Some reactive output displayed as a result of server calculations
4)You must also include enough documentation so that a novice user could use your application.
5)The documentation should be at the Shiny website itself. Do not post to an external link.
'


library(shiny)
shinyUI(fluidPage(
    titlePanel("Prediction Applications - mtcars and tree data"),
        
    sidebarLayout(
        sidebarPanel(
            tags$div(`data-value` = "tab head",
                tags$h3("Documentation"),
                ),
            tags$div(`data-value` = "tab 1",
                     tags$i("Tab 1 - Prediction on tree Data"),
                     br(),
                     tags$blockquote("Usage Guide : ",
                     br(),
                     tags$small("Hover to the plot, and select the points to be used for prediction."),
                     tags$small("The intercept and Slope value will be displayed below"),
                     ),
                 ),
            tags$div(`data-value` = "tab 2",
                     tags$i("Tab 2 -  mpg prediction with 2 linear models on mtcars dataset"),
                     br(),
                     tags$blockquote("Usage Guide : ",
                                     br(),
                                     tags$small("Select the input value on top of the plot"),
                                     tags$small("Hide or show the linear model by selecting the checkbox below the plot"),
                                     tags$small("The predicted value for each model would be shown below the model selection checkbox"),
                     ),
                ),
            tags$div(`data-value` = "tab 3",
                     tags$i("Tab 3 -  mpg prediction on one linear model by selecting input data on mtcars dataset"),
                     br(),
                     tags$blockquote("Usage Guide : ",
                                     br(),
                                     tags$small("Select the input value by highlighting in on the plot"),
                                     tags$small("The predicted value would be shown below the plot"),
                     ),
            ),
            
            tags$div(`data-value` = "tab 4",
                     tags$i("Tab 4 -  mpg prediction by selecting input data on mtcars dataset and SVM model"),
                     br(),
                     tags$blockquote("Usage Guide : ",
                                     br(),
                                     tags$small("Select the input value by highlighting in on the plot"),
                                     #tags$small("The predicted value would be shown below the plot"),
                     ),
            ),
            
       ),
        mainPanel(
            
            tabsetPanel(type = "tabs", 
                        
                
                tabPanel("tab1 - tree data prediction", 
                         plotOutput("plot2", brush = brushOpts(
                    id = "brush1"
                    )),
                    #sidebarPanel(
                        h3("Slope"),
                        textOutput("slopeOut"),
                        h3("Intercept"),
                        textOutput("intOut")
                    #)
                
                ),
                
                tabPanel("Tab2 - mtcars mpg prediction with 2 models", 
                         tags$div(`data-value` = "plot 1",
                             sliderInput("sliderMPG", "What is the MPG of the car?", 10, 35, value = 20),
                             plotOutput("plot1"),
                         ),
                         tags$div(`data-value` = "plot 1 - remainig",
                             checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
                             checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
                             h4("Predicted Horsepower from Model 1:"),
                             textOutput("pred1"),
                             h4("Predicted Horsepower from Model 2:"),
                             textOutput("pred2"),
                         ),
                         #submitButton("Submit")
                ),
                
                tabPanel("Tab3 -mtcars mpg prediction by selection, linear model", 
                         tags$div(`data-value` = "plot 3",
                             plotOutput("plot3", brush = brushOpts(
                                 id = "brush2"
                             )),
                         ),
                         tags$div(`data-value` = "plot 3 - others",
                         #sidebarPanel(
                             h3("Slope"),
                             textOutput("slopeOut2"),
                             h3("Intercept"),
                             textOutput("intOut2")
                         #)
                         ),
                         
                ),
                
                tabPanel("Tab4 -mtcars mpg prediction by selection, svm model", 
                         tags$div(`data-value` = "plot 4",
                                  plotOutput("plot4", brush = brushOpts(
                                      id = "brush3"
                                  )),
                         ),
                         tags$div(`data-value` = "plot 4 - others",
                                  #sidebarPanel(
                                  #h3("Predicted Value"),
                                  #textOutput("predVal"),
                                  #h3("Intercept"),
                                  #textOutput("intOut2")
                                  #)
                         ),
                         
                )
            )
        )
    )
))
