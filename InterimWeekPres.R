
#| eval: false
library(dplyr)
library(DBI)
library(dbplyr)
library(odbc)
library(tictoc)

odbcListDrivers()

con <- DBI::dbConnect(odbc(),
                      Driver = "ODBC Driver 17 for SQL Server",
                      Server = "mcobsql.business.nd.edu",
                      UID = "MSBAstudent",
                      PWD = "SQL%database!Mendoza",
                      Port = 3306, 
                      Database = "ChicagoCrime")

dbListFields(con, "wards")

dbListFields(con, "crimes")

# build the query

select_q <- dbSendQuery(
  conn = con, 
  statement = "SELECT ward, percentIncomeUnder25K, percentWhite FROM wards"
)

select_res <- dbFetch(select_q)

dbClearResult(select_q)


library(ggplot2)
ggplot(select_res, aes(x = select_res$ward, y = select_res$percentIncomeUnder25K, fill = select_res$percentWhite)) +
         geom_col()+
  labs(x = 'ward', y = 'Percent Income < $25000', fill = 'Percent White') +
  ggtitle('Percent Income < $25000 for Each Ward')+
  theme_minimal()
  
