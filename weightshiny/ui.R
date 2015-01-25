# ui.R

shinyUI(fluidPage(
  titlePanel("Study Weight Loss"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("resp", 
        label = "Choose a response to see",
        choices = c('Waist.AM', 
                    'Waist.PM', 
                    'Chest.AM', 
                    'Chest.PM', 
                    'Hip.AM',
                    'Hip.PM',
                    'Weight.AM',
                    'Weight.PM', 
                    'Fat.L', 
                    'Fat.R'),
        selected = "Weight.PM"
        )
    ),
    
    mainPanel(plotOutput('plot'))
  )
))
