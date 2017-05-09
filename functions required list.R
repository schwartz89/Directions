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

DataTransfer <- function(x,oldnames,newnames){
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
  df <- data.frame(matrix(NA, nrow = nrow(x), ncol = ncol(x))) #output df
  colnames(df)<- colnames(x)
  setnames(df, old = oldnames, new = newnames)
  
  df #?
}#working great but for some reason is applying change to original doc. lolhow



# F4. Export function. Grabs data and prints it to appropriate .csv. 
# Structures/dataframe naming convention in F3 will likely help here.