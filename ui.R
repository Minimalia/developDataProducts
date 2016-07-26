library(shiny)

# Define UI for slider demo application
shinyUI(pageWithSidebar(
        
        #  Application title
        headerPanel("Feature selection using RFE"),
        
        # Sidebar with user options
        sidebarPanel(
                
#                 # Action button
#                 tags$div(class="header", checked=NA,
#                          tags$a(href="shiny.rstudio.com/tutorial", "Help")
#                 ),
                
                p("Click the button to see selected features and estimated K-fold cross validation accuracy."),
                actionButton("runButton", "Run!"),
                
                # Radiobutton
                radioButtons("outcome", "Outcome:",
                             list("Miles per US gallon (mpg)" = "mpg",
                                  "Number of cylinders (cyl)" = "cyl",
                                  "Displacement (disp)" = "disp",
                                  "Gross horsepower (hp)" = "hp",
                                  "Rear axle ratio (drat)" = "drat",
                                  "Weight (wt)" = "wt",
                                  "1/4 mile time (qsec)" = "qsec",
                                  "V/S (vs)" = "vs",
                                  "Transmission (am)" = "am",
                                  "Number of forward gears (gear)" = "gear",
                                  "Number of carburetors (carb)" = "carb")),
                
                # Combo box
                selectInput("funcs", "Select function:", 
                            choices = c("Random Forest", "Linear Regression")),
                
                # Integer interval with step value
                sliderInput("kfold", "k-fold:", 
                            min = 10, max = 90, value = 10 ,step = 10)
                
        ),
        
        # Show a table summarizing the values entered
        mainPanel(
                # Documentation
                tabsetPanel(
                        tabPanel("RFE",plotOutput('plotFeat')),
                        tabPanel("Features",verbatimTextOutput("featToKeep")),
                        tabPanel("Documentation", includeHTML("README.html")))
        )
        
        
        
))