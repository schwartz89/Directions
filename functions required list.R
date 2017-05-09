# Functions Needed for MasterCare Transfer

# F1. Import function. Imports all revelant datasheets. DONE.
# 




# F2. Remove emptycols for easy viewing. 
# 





# F3. Take input of an excel doc with two columns “OldLocation”, “NewLocation” 
# and loop through, taking data from oldlocation and move it to newlocation. 
# “OldVarName” “NewVarName” might be a better way to conceptualise this. 
# Really you’re just renaming.
#

DataTransfer <- function(X,oldnames,newnames){
 #Package Installation
  Required.packages <- c("data.table")
  Missing.packages <- Required.packages[!(Required.packages %in% installed.packages()[ , "Package"])] 
  if(length(Missing.packages)) install.packages(Missing.packages)
 #Package loading
  library(data.table)
 
 #Convert names to character (neccesary?)
  oldnames     <- as.character(oldnames)
  newnames     <- as.character(newnames)
 #Renaming function  
  df<-cbind(X) #clones X so I don't edit it
  df <- setnames(df, old = oldnames, new = newnames)
  df #?
  
  #scrap all non-renamed data? Or do this externally?
 #This could be done by using newnames variable, or doing a list compare
 #between original and new docs and deleting replicates
}



# F4. Export function. Grabs data and prints it to appropriate .csv. 
# Structures/dataframe naming convention in F3 will likely help here.





#Scrapped code
# df <- data.frame(matrix(NA, nrow = nrow(X), ncol = ncol(X))) #blank df