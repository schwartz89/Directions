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

-------------
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
  
#this also works
  #library("data.table")
  # CC<-as.data.table(CC)
  # MC<-as.data.table(MC)
  # joined <- MC[C_V, on = c("ClientIdentifier" = "PAT.ID")] #You specify which column to paste into within the joining syntax
#as does
  # setkey(CC, PAT.ID)
  # setkey(MC, ClientIdentifier)
  # Kjoined <- MC[CC]

##Updating data by index (if your plugging in extra data from seperate source
  #and want it to match by PID)
  #CCupdate <- data.table(ID = CC$PAT.ID, Sex = CC$PAT.SEX) #creating table of data to be added, with PID in left column
  #setkey(CCupdate, ID) #optional?
  #MC$Sex <- CCupdate[match(MC$ClientIdentifier, CCupdate$ID),2] #inserting and matching by ID. The ',2' is specifying that data to be added is in col 2.
    
#selecting in Data.table
  #C_V2<- C_V[ ,list(DATE.OF.BIRTH,PAT.ID,ADDR.1,FORENAMES,SURNAME)] #first arg blank because you want ALL obs
  
  
#TODO combine with above function?
  
  #updating data in df
  # MC$colname <- NewCC[match(MC$PID, NewCC$PID), 2]
  
  #setkey() #data.table
  #select() #dplyr
  #https://rawgit.com/wiki/Rdatatable/data.table/vignettes/datatable-reference-semantics.html
  # := #data.table
  
  # ## joins using < v1.9.6 
  # setkey(X, a) # absolutely required
  # setkey(Y, a) # not absolutely required as long as 'a' is the first column
  # X[Y]
  # ## joins using v1.9.6+
  # X[Y, on="a"]
  # # or if the column names are x_a and y_a respectively
  # X[Y, on=c("x_a" = "y_a")]
  
  #1# setkey(ZIP,zipcode)
  #2# setkey(PPL,zipcode)
  #3# full.info <- PPL[ZIP, nomatch=F]
  
  ##mutating join #see dplyr two-table vignette
    #full_join() joining by: index 
    #semi_join()
  }



#------------
# F4. Export function. Grabs data and prints it to appropriate .csv. 
# Structures/dataframe naming convention in F3 will likely help here.





#Scrapped code
# df <- data.frame(matrix(NA, nrow = nrow(X), ncol = ncol(X))) #blank df