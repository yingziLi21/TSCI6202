library(jsonlite);
library(rio);
library(dplyr);
library(ggplot2);
makegeomline<-function(yy,ycol){
  #browser()
  geom_line(aes_string(y=yy),col=ycol)
}
if(!file.exists('cached_data.tsv')){"nonexists"
  data0<- jsonlite::fromJSON('https://services.arcgis.com/g1fRTDLeMgspWrYp/arcgis/rest/services/SAMHD_DailySurveillance_Data_Public/FeatureServer/0/query?where=1%3D1&outFields=*&returnGeometry=false&outSR=4326&f=json')
  data1<-data0$features$attributes %>%
    mutate(reporting_date=(reporting_date/1000)%>% as.POSIXct(origin = "1970-01-01"))%>%
    subset(reporting_date>="2020-3-19")
  export(data1,"cached_data.tsv")
}else{"exists"
  data1<-import("cached_data.tsv")
}
#test
input<-list(yvals=c("total_case_daily_change","strac_covid_positive_in_hospita"),c("red","darkgreen"))
ggplot(data1,aes(x=reporting_date))+mapply(makegeomline,input$yvals,input$ycols)


