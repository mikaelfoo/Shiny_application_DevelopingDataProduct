#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library('e1071')

shinyServer(function(input, output) {
    mtcars$mpgsp <- ifelse(mtcars$mpg - 20 > 0, mtcars$mpg - 20, 0)
    model1 <- lm(hp ~ mpg, data = mtcars)
    model2 <- lm(hp ~ mpgsp + mpg, data = mtcars)
    
    model1pred <- reactive({
        mpgInput <- input$sliderMPG
        predict(model1, newdata = data.frame(mpg = mpgInput))
    })
    
    model2pred <- reactive({
        mpgInput <- input$sliderMPG
        predict(model2, newdata = 
                    data.frame(mpg = mpgInput,
                               mpgsp = ifelse(mpgInput - 20 > 0,
                                              mpgInput - 20, 0)))
    })
    
    output$plot1 <- renderPlot({
        mpgInput <- input$sliderMPG
        
        plot(mtcars$mpg, mtcars$hp, xlab = "Miles Per Gallon", 
             ylab = "Horsepower", bty = "n", pch = 16,
             xlim = c(10, 35), ylim = c(50, 350))
        if(input$showModel1){
            abline(model1, col = "red", lwd = 2)
            points(mpgInput, model1pred(), col = "red", pch = 16, cex = 2)
        }
        if(input$showModel2){
            model2lines <- predict(model2, newdata = data.frame(
                mpg = 10:35, mpgsp = ifelse(10:35 - 20 > 0, 10:35 - 20, 0)
            ))
            lines(10:35, model2lines, col = "blue", lwd = 2)
            points(mpgInput, model2pred(), col = "blue", pch = 16, cex = 2)
        }
        legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
               col = c("red", "blue"), bty = "n", cex = 1.2)
        
        
    })
    
    output$pred1 <- renderText({
        if(input$showModel1){
        model1pred()
        }
        else{
        "model hidden"
        }
    })
    
    output$pred2 <- renderText({
        if(input$showModel2){
        model2pred()
        }
        else{
        "model hidden"
        }
    })
    
    model <- reactive({
        brushed_data <- brushedPoints(trees, input$brush1,
                                      xvar = "Girth", yvar = "Volume")
        if(nrow(brushed_data) < 2){
            return(NULL)
        }
        lm(Volume ~ Girth, data = brushed_data)
    })
    
    model3 <- reactive({
        brushed_data2 <- brushedPoints(mtcars, input$brush2,
                                      xvar = "mpg", yvar = "hp")
        if(nrow(brushed_data2) < 2){
            return(NULL)
        }
        lm(hp ~ mpg, data = brushed_data2)
    })
    
    model4 <- reactive({
        brushed_data3 <- brushedPoints(mtcars, input$brush3,
                                       xvar = "mpg", yvar = "hp")
        if(nrow(brushed_data3) < 2){
            return(NULL)
        }
        svmod<-svm(brushed_data3$hp ~ brushed_data3$mpg)
        yv<-predict(svmod, brushed_data3$mpg)
        lines(x = brushed_data3$mpg, y = yv, col="red", cex = 1, pch = 16)
        #return(yv)
        #return(data.frame(brushed_data3$mpg,yv))
    })
    
    output$slopeOut <- renderText({
        if(is.null(model())){
            "No Model Found"
        } else {
            model()[[1]][2]
        }
    })
    
    output$slopeOut2 <- renderText({
        if(is.null(model3())){
            "No Model Found"
        } else {
            model3()[[1]][2]
        }
    })
    
    output$intOut <- renderText({
        if(is.null(model())){
            "No Model Found"
        } else {
            model()[[1]][1]
        }
    })
    
    output$intOut2 <- renderText({
        if(is.null(model3())){
            "No Model Found"
        } else {
            model3()[[1]][1]
        }
    })
    
    output$predVal <- renderText({
        if(is.null(model4())){
            "No Model Found"
        } else {
            model4()[]
        }
        
    })
    output$plot2 <- renderPlot({
        plot(trees$Girth, trees$Volume, xlab = "Girth",
             ylab = "Volume", main = "Tree Measurements",
             cex = 1.5, pch = 16, bty = "n")
        if(!is.null(model())){
            abline(model(), col = "blue", lwd = 2)
        }
    })
    
    output$plot3 <- renderPlot({
        plot(mtcars$mpg, mtcars$hp, xlab = "mpg",
             ylab = "hp", main = "mtcars dataset - mpg prediction",
             xlim = c(10, 35), ylim = c(50, 350),
             cex = 1.5, pch = 16, bty = "n")
        if(!is.null(model3())){
            abline(model3(), col = "green", lwd = 2)
        }
    })
    
    output$plot4 <- renderPlot({
        plot(mtcars$mpg, mtcars$hp, xlab = "mpg",
             ylab = "hp", main = "mtcars dataset - mpg prediction by SVM",
             xlim = c(10, 35), ylim = c(50, 350),
             cex = 1.5, pch = 16, bty = "n")
        if(!is.null(model4())){
            #abline(model4(), col = "violet", lwd = 2)
            #model_4 <- model4()
            model4()
            #lines(x = points$mpg, y = points$yv, col="red", cex = 1, pch = 16)
        }
    })
    

})
