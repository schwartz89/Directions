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

MC.Setnames <- function(X,oldnames,newnames){
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
  
  #change input arg to a 2 column matrix? Or a GUI-selected excel doc?
}

#-------------
# F3B Function to move data, whilst row-matching by participant ID.
# The previous function does not do this, it only renames. This is fine
# if all data comes from the same Comunicare report. However the data
# is sourced from multiple reports, which do NOT match up row for row
# and are different row lengths.

MC.Movedata<-function(CCdata, MCtemplate){
#This function moves and binds data from one dataset to another. By default 
#it uses common columns to index by (ideally an ID), this can be specified.
#since colnames must match for this to be useful, this function works in
#tandem with the above.
  
  x <- full_join(MCtemplate, CCdata) #by = "PID") #this is optional, should do it auto, can specify multiple cols to index by if needed (for validation)
  x
  
  
  
#TODO combine with above function?
  
  
  #setkey() #data.table
  #select() #dplyr
  
  ##mutating join #see dplyr two-table vignette
    #full_join() joining by: index 
    #semi_join()
  }



#------------
# F4. Export function. Grabs data and prints it to appropriate .csv. 
# Structures/dataframe naming convention in F3 will likely help here.





#Scrapped code
# df <- data.frame(matrix(NA, nrow = nrow(X), ncol = ncol(X))) #blank df