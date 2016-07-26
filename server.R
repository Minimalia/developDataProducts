library(shiny)
library(caret)
library(randomForest)
library(datasets)

getOutcome <- function(outcome){
        mtcars[,outcome]
}

getPredictors <- function(outcome){
        predictVar <- mtcars[, !(names(mtcars) %in% outcome)]
        predictVar
}

runRFE <- function(outcomeVar,predictVar,kfold,funcs){
        numFeat <- dim(predictVar)[2]
        set.seed(12345)
        
        # Processing...
        control <- rfeControl(functions=rfFuncs, method="cv", number=kfold)        
        
        if (funcs == "Linear Regression"){ # rfFuncs
                
                control <- rfeControl(functions=lmFuncs, method="cv", number=kfold)        
                
        }
        
        # Recursive feature elimination:
        featSelection <- rfe(predictVar, outcomeVar, sizes=1:numFeat,rfeControl=control)
        featSelection
}

# Define server logic for slider examples
shinyServer(function(input, output) {
        
        observeEvent(input$runButton, {
        
                outcome <- reactive({input$outcome})
                kfold <- reactive({input$kfold})
                funcs <- reactive({input$funcs})
                
                currentOutcome <- reactive({getOutcome(outcome())})
                currentPredictors <- reactive({getPredictors(outcome())})
                
                currentFeatSelection <- reactive({
                        runRFE(currentOutcome(),currentPredictors(),kfold(),funcs())
                })
                
                output$plotFeat <- renderPlot({
                        plot(currentFeatSelection(), type=c("g", "o"))        
                })        
                
                output$featToKeep <- renderPrint({
                        predictors(currentFeatSelection())
                })
        
        })
              
})