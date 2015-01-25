library(plyr)
library(ggplot2)
library(reshape2)

# copy the following so you can do sme()
WORKDIRECTORY='/Users/junhe/workdir/weight'
THISFILE     ='analysis.R'
setwd(WORKDIRECTORY)
sme <- function()
{
    setwd(WORKDIRECTORY)
    source(THISFILE)
}



explore.weight <- function()
{
    transfer <- function()
    {
    }
    
    load <- function()
    {
        d = read.table('./table', header=T)
        print(head(d))
        return(d)
    }
    
    clean <- function(d)
    {
        d = melt(d, id=c('Date', 'Rice', 'Gym'), 
                 #measure=c('Weight.AM', 'Weight.PM'))
                 #measure=c('Waist.AM', 'Waist.PM'))
                 measure=c('Weight.PM'))

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
            geom_line(aes(group=linegroup, linetype = variable)) +
            #scale_y_continuous(breaks=seq(30, 40, 1), limits=c(34, 36))+
            scale_y_continuous(breaks=seq(0, 200, 0.5))+
            xlab('Date') +
            theme_bw() +
            theme(axis.text.x = element_text(angle=90)) 
        print(p)
    }
    
    do_main <- function()
    {
        d = load()
        d = clean(d)
        func(d)
    }
    do_main()
}

main <- function()
{
    explore.weight()   
}

main()
