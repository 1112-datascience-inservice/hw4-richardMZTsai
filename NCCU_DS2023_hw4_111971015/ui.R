ui <- fluidPage(
  
  mainPanel(
    titlePanel("Interactive CA,PCA Explorer")

    ,
        
        tabsetPanel(
          tabPanel("Compute CA",
                   
                   p("Choose the columns of your data to include in the CA."),
                   uiOutput("choose_columns_ca"),
                   tags$hr(),
                   actionButton(inputId = "run_ca_button", label = "Run CA"),
                   tags$hr(),
                   plotOutput("caPlot", height = 400),
                   tags$hr(),
                   tableOutput("caTable")
          ),
          
          tabPanel("Correlation Plots",
                   uiOutput("choose_columns_biplot"),
                   tags$hr(),
                   p("This plot may take a few moments to appear when analysing large datasets. You may want to exclude highly correlated variables from the PCA."),
                   
                   plotOutput("corr_plot"),
                   tags$hr(),
                   p("Summary of correlations"),
                   tableOutput("corr_tables")
          ), # end  tab
          tabPanel("Compute PCA",
                   
                   p("Choose the columns of your data to include in the PCA."),
                   uiOutput("choose_columns_pca"),
                   tags$hr(),
                   p("Select options for the PCA computation (we are using the prcomp function here)"),
                   radioButtons(inputId = 'center',  
                                label = 'Center',
                                choices = c('Shift variables to be zero centered'='Yes',
                                            'Do not shift variables'='No'), 
                                selected = 'Yes'),
                   
                   radioButtons('scale.', 'Scale',
                                choices = c('Scale variables to have unit variance'='Yes',
                                            'Do not scale variables'='No'), 
                                selected = 'Yes')
                   
          ), # end  tab
          tabPanel("PC Plots",
                   h2("Scree plot"),
                   p("The scree plot shows the variances of each PC, and the cumulative variance explained by each PC (in %) "),
                   plotOutput("plot2", height = "300px"),
                   tags$hr(),
                   h2("PC plot: zoom and select points"),
                   p("Select the grouping variable."),
                   p("Only variables where the number of unique values is less than 10% of the total number of observations are shown here (because seeing groups with 1-2 observations is usually not very useful)."),
                   uiOutput("the_grouping_variable"),
                   tags$hr(),
                   p("Select the PCs to plot"),
                   uiOutput("the_pcs_to_plot_x"),
                   uiOutput("the_pcs_to_plot_y"),
                   tags$hr(),
                   
                   p("Click and drag on the first plot below to zoom into a region on the plot. Or you can go directly to the second plot below to select points to get more information about them."),
                   p("Then select points on zoomed plot below to get more information about the points."),
                   p("You can click on the 'Compute PCA' tab at any time to change the variables included in the PCA, and then come back to this tab and the plots will automatically update."),
                   plotOutput ("z_plot1", height = 400,
                               brush = brushOpts(
                                 id = "z_plot1Brush",
                                 resetOnNew = TRUE)),
                   tags$hr(),
                   
                   p("Click and drag on the plot below to select points, and inspect the table of selected points below"),

                   plotOutput("z_plot2", height = 400,
                              brush = brushOpts(
                                id = "plot_brush_after_zoom",
                                resetOnNew = TRUE)),
                   tags$hr()
          )


          
          )))