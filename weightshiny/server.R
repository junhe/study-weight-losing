# server.R
library(plyr)
library(ggplot2)
library(reshape2)

shinyServer(
  function(input, output) {
  
    output$text1 <- renderText({ 
      paste("You have selected", input$resp)
    })
      
    output$plot <- renderPlot({
        load <- function()
        {
            d = read.table('./data/table', header=T)
            print(head(d))
            return(d)
        }
        
        clean <- function(d)
        {
            print(input$resp)
            d = melt(d, id=c('Date', 'Rice', 'Gym'), 
                     measure=c(input$resp))

            d$Rice = revalue(d$Rice, c('Yes'='EatRice',
                                       'No' ='NoRice'))
            d$Gym = revalue(d$Gym, c('Yes'='Gym',
                                     'No' ='NoGym'))

            d$newdate <- strptime(d$Date, "%m/%d/%y")
            d$newdate <- as.POSIXct(d$newdate)
            d$newdate <- format(d$newdate, format="%y-%m-%d")

            d$treatment = interaction(d$Rice, d$Gym)
            d$linegroup = interaction(d$treatment, d$variable)

            return(d)
        }
        
        func <- function(d)
        {
            p <- ggplot(d, aes(x=newdate, y=value, color=treatment)) +
                geom_point() +     
                geom_line(aes(group=linegroup)) +
                scale_y_continuous(breaks=seq(0, 200, 0.5))+
                xlab('Date') +
                ylab(input$resp) +
                theme_bw() +
                theme(axis.text.x = element_text(angle=90, vjust=0.5)) 
            print(p)
        }
        
        do_main <- function()
        {
            d = load()
            d = clean(d)
            func(d)
        }
        do_main()

    })
  }
)

