####SCRIPT OUTLINE AND GOALS####
  #data migration for Directions from Communicare to Mastercare
  #goal: identify which variables in communicare data output csv map to which variables in mastercare input (multiple) csv's
  #then write a script to cut and paste from one to the other, while retaining the original format of the mastercare input csv's
  
  #thougths. I think I need to find a way to do structures in R. That way I can structure each seperate mastercare variable to link it to it's
  #source csv. This will also make writing to file much easier in the end.
  
  ##import all -> name cleverly -> recode/reformat inappropriate data -> transfer data from C to M -> export, matching origin format

####IMPORTING DATA####   
  #import Mastercare templates using home adress to be easier to transfer computers.  
     Appointment <- read.csv(file="Appointment.csv")
     View(Appointment)
     ClientDemographics <- read.csv(file = "ClientDemographics.csv", header=TRUE)
     View(ClientDemographics)
     ClientGP <- read.csv(file = "ClientGP.csv")
     View(ClientGP)
     ClientOtherLanguage <- read.csv(file = "ClientOtherLanguage.csv")
     View(ClientOtherLanguage)
     FamilyHistory <- read.csv(file = "FamilyHistory.csv")
     View(FamilyHistory)
     GP <- read.csv(file = "GP.csv", header=TRUE)
     View(GP)
     ClientDemographics <- read.csv(file = "ClientDemographics.csv", header=TRUE)
     View(ClientDemographics)
     HealthCareCard <- read.csv(file = "HealthCareCard.csv")
     View(HealthCareCard)
     ICD10 <- read.csv(file = "ICD10.csv")
     View(ICD10)
     ICPC <- read.csv(file = "ICPC.csv")
     View(ICPC)
     NOK <- read.csv(file = "NOK.csv", header=TRUE)
     View(NOK)
     Referral <- read.csv(file = "Referral.csv")
     View(Referral)
     Referral_BoiMH <- read.csv(file = "Referral_BoiMH.csv", header=TRUE)
     View(Referral_BoiMH)
     Session <- read.csv(file = "Session.csv")
     View(Session)
     Staff <- read.csv(file = "Staff.csv")
     View(Staff)
     StaffTeam <- read.csv(file = "StaffTeam.csv")
     View(StaffTeam)
     Team <- read.csv(file = "Team.csv")
     View(Team)
     
  #import Communicare data
     DirectionsClinicalExtract <- read.csv("DirectionsClinicalExtract.csv")
       View(DirectionsClinicalExtract)
       
####WRANGLING/SUBDIVIDING IMPORTED DATA####
  #select vital data and subdivide this into a new dataset
  
      #grab columns that have no data and list their name
      Dir_isempty<-sapply(DirectionsClinicalExtract, function(x)all(is.na(x)))
      Dir_Names_emptycols <- names(Dir_isempty[Dir_isempty>0]) #this grabs the TRUEs
      print("the columns with all values missing")
      print(Dir_Names_emptycols)
  
      #get all cols WITH data
      Dir_Names_usedcols <- names(Dir_isempty[Dir_isempty<1]) #this is all columns with data
      print("the columns that contain data")
      print(Dir_Names_usedcols)
  
      
  #Create new dataset with all emptycols removed
      Communicare <- DirectionsClinicalExtract[Dir_Names_usedcols]
  
  #congregation of definitely vital data (use manual inspection for this)
      Communicare_Vital<-Communicare[c(
                                      "PAT.ID",
                                      "PAT.SEX",
                                      "DATE.OF.BIRTH",
                                      "PAT.HDWA.MRN", #SLK
                                      "MEDICARE.NO",
                                      "MEDICARE.REF.NO",
                                      "MEDICARE.EXPIRY",
                                      "OLD.PENSION.NO",
                                      "FORENAMES",
                                      "SURNAME",
                                      "ADDR.1",
                                      "ADDR.2",
                                      "PHONE",
                                      "KIN.NAME1",
                                      "BIRTHPLACE",
                                      "MOBILE.PHONE",
                                      "WORK.PHONE",
                                      "EMERGENCY.CONTACT.NAME",
                                      "EMERGENCY.CONTACT.PHONE",
                                      "HCC.EXPIRY",
                                      "FULL.NAME",
                                      "ABORIGINAL",
                                      "CRN.NO")]
              
  
  #congregation of maybe useful data    
      Communicare_useful<-Communicare[c(
                                      "SERVICE.PROVIDER.NO",
                                      "MORB.TYPE.SHORT.DESC",
                                      "MORB.TYPE.SHORT.DESC.UC",
                                      "SYS.CODE",
                                      "ICPC.CODE",
                                      "NAT.LAN.TERM",
                                      "MORB.RIGHT.NO",
                                      "PREG.COMPLICATION",
                                      "UNIQUE.ID",
                                      "PAT.ID.1",
                                      "LOCALITY.NO",
                                      "AB.TYPE.NO",
                                      "KIN.TYPE1",
                                      "CURRENT.STATUS",
                                      "EMERGENCY.CONTACT.TYPE",
                                      "HIC.BULK.ELIGIBLE",
                                      "FIRST.FORENAME",
                                      "MARITAL.STATUS.NO",
                                      "LANGUAGE.NO",
                                      "BIRTH.CTRY.NO",
                                      "CENTRELINK.TYPE.CODE",
                                      "HCC.NO", #double up with CRN.NO
                                      "DOB.ESTIMATED", #t/f tickbox
                                      "HIC.ELIGIBILITY.LAST.CHECKED",
                                      "NTHC.SEND.DRUG.ALLERGY",
                                      "LANGUAGE.HOME.NO",
                                      "NO.KNOWN.REACTIONS",
                                      "CTG.REGISTERED",
                                      "BP.IMPORTED.PAT.ID",
                                      "PREFERRED.CONTACT",
                                      "HAS.NO.PHONE",
                                      "RECORD.STORAGE.SITE.NO",
                                      "HIC.BULK.BILL",
                                      "HIC.CLAIM.STATUS",
                                      "HIC.DB4.PRINTED",
                                      "HIC.NON.CLAIMABLE",
                                      "REASON.MORB.NO",
                                      "PROVIDER.NO.1",
                                      "SPECIALITY.TYPE.NO",
                                      "D.GENDER", #dr gender?
                                      "DOH.PRESCRIBER.NO",
                                      "QUALIFICATIONS",
                                      "TITLE", #of dr
                                      "BP.USERID")]
     
      
  #All remaining non-useful data by subracting the two useful sets from the full communicare set (still excluding the empty columns)
    Communicare_Vital_N<-names(Communicare_Vital)
    Communicare_useful_N<-names(Communicare_useful)
    Communicare_trash <- Communicare[ , !(names(Communicare) %in% c(Communicare_Vital_N,Communicare_useful_N))] 
    
  #save all subdivided communicare data to csv.
    write.csv(Communicare_Vital, file = "Communicare_Vital.csv")
    write.csv(Communicare_useful, file = "Communicare_useful.csv")
    write.csv(Communicare_trash, file = "Communicare_trash.csv")  
    write.csv(Communicare, file = "Communicare.csv") 
  
    
####DATA TRANSFER####
  #making a blank dataframe that matches MasterCare's to put the data into
      ClientDemographics_N <-data.frame(matrix(NA, nrow = nrow(DirectionsClinicalExtract), ncol = ncol(ClientDemographics)))  #copies dimensions of ClientDemographics #removed nrows  

#####Data transfer template#####
    #Adding variable to workspace
      #Sex<-DirectionsClinicalExtract[["Sex"]] #[["PAT.SEX"]]
    #merging variable to new data frame
      #ClientDemographics_N<-cbind(Sex,ClientDemographics_N); 

####EXECUTING TRANSFER####
  #now repeat this formula for all data  
  #can I just write a function to do this?
  
  Sex<-DirectionsClinicalExtract[["Sex"]] #[["PAT.SEX"]]
  ClientDemographics_N<-cbind(Sex,ClientDemographics_N);  
    
  DOB<-DirectionsClinicalExtract[["DATE.OF.BIRTH"]] #these line pair works. But function below doesn't yet.
  ClientDemographics_N<-cbind(DOB,ClientDemographics_N); 
  
  FirstName<-DirectionsClinicalExtract[["FORENAMES"]]
  ClientDemographics_N<-cbind(FirstName,ClientDemographics_N); 
  
  Surname<-DirectionsClinicalExtract[["SURNAME"]]
  ClientDemographics_N<-cbind(Surname,ClientDemographics_N); 
  
  AddressLine1<-DirectionsClinicalExtract[["ADDR.1"]]
  ClientDemographics_N<-cbind(AddressLine1,ClientDemographics_N); 
  
  AddressLine2<-DirectionsClinicalExtract[["ADDR.2"]]
  ClientDemographics_N<-cbind(AddressLine2,ClientDemographics_N); 
  
  PhoneBH<-DirectionsClinicalExtract[["PHONE"]]
  ClientDemographics_N<-cbind(PhoneBH,ClientDemographics_N); 
  
  Mobile<-DirectionsClinicalExtract[["MOBILE.PHONE"]]
  ClientDemographics_N<-cbind(Mobile,ClientDemographics_N); 
  
  CountryOfBirth<-DirectionsClinicalExtract[["BIRTHPLACE"]]
  ClientDemographics_N<-cbind(CountryOfBirth,ClientDemographics_N);   
  
  IndigenousStatus<-DirectionsClinicalExtract[["ABORIGINAL"]]
  ClientDemographics_N<-cbind(IndigenousStatus,ClientDemographics_N);   

####TRANSFER LOCATIONS LIST (for easy copypaste access)####
  #vital data
#   "PAT.ID", #ALL
#   "PAT.SEX",ClientDemographics
#   "DATE.OF.BIRTH", ClientDemographics
#   "PAT.HDWA.MRN", #SLK #ALL
#   "MEDICARE.NO", HealthCareCard
#   "MEDICARE.REF.NO",HealthCareCard
#   "MEDICARE.EXPIRY",HealthCareCard
#   "OLD.PENSION.NO",HealthCareCard
#   "FORENAMES",ClientDemographics
#   "SURNAME",ClientDemographics
#   "ADDR.1",ClientDemographics
#   "ADDR.2",ClientDemographics
#   "PHONE",ClientDemographics
#   "KIN.NAME1",NOK
#   "BIRTHPLACE",ClientDemographics
#   "MOBILE.PHONE",ClientDemographics
#   "WORK.PHONE",ClientDemographics
#   "EMERGENCY.CONTACT.NAME",NOK
#   "EMERGENCY.CONTACT.PHONE",NOK
#   "HCC.EXPIRY",HealthCareCard
#   "FULL.NAME",ClientDemographics
#   "ABORIGINAL",ClientDemographics
#   "CRN.NO")]HealthCareCard
#    
#    #maybe useful data
#    "SERVICE.PROVIDER.NO",GP, Staff
#    "MORB.TYPE.SHORT.DESC",
#    "MORB.TYPE.SHORT.DESC.UC",
#    "SYS.CODE",
#    "ICPC.CODE", ICPC
#    "NAT.LAN.TERM",
#    "MORB.RIGHT.NO",
#    "PREG.COMPLICATION",nowhere
#    "UNIQUE.ID",ALL? Redundant?
#    "PAT.ID.1",ALL? Redundant?
#    "LOCALITY.NO",ClientDemographics
#    "AB.TYPE.NO",
#    "KIN.TYPE1",NOK?
#    "CURRENT.STATUS",
#    "EMERGENCY.CONTACT.TYPE",NOK
#    "HIC.BULK.ELIGIBLE", nowhere
#    "FIRST.FORENAME",ClientDemographics redundant?
#    "MARITAL.STATUS.NO",ClientDemographics
#    "LANGUAGE.NO",ClientDemographics & maybe ClientOtherLanguage
#    "BIRTH.CTRY.NO",ClientDemographics (redundant?)
#    "CENTRELINK.TYPE.CODE",
#    "HCC.NO", HealthCareCard redundant #doubled up with CRN.NO
#    "DOB.ESTIMATED", nowhere #t/f tickbox
#    "HIC.ELIGIBILITY.LAST.CHECKED", nowhere
#    "NTHC.SEND.DRUG.ALLERGY",nowhere
#    "LANGUAGE.HOME.NO",ClientDemographics
#    "NO.KNOWN.REACTIONS", nowhere
#    "CTG.REGISTERED",
#    "BP.IMPORTED.PAT.ID", nowhere
#    "PREFERRED.CONTACT",ClientDemographics or nowhere
#    "HAS.NO.PHONE", nowhere
#    "RECORD.STORAGE.SITE.NO", nowhere
#    "HIC.BULK.BILL",
#    "HIC.CLAIM.STATUS",
#    "HIC.DB4.PRINTED",
#    "HIC.NON.CLAIMABLE",
#    "REASON.MORB.NO",
#    "PROVIDER.NO.1", ClientGP, GP?
#    "SPECIALITY.TYPE.NO", ClientGP, GP?
#    "D.GENDER", ClientGP, GP? #dr gender? 
#    "DOH.PRESCRIBER.NO", GP
#    "QUALIFICATIONS", nowhere
#    "TITLE", ClientGP, GP?#of dr
#    "BP.USERID")] nowehere
#    

   
  
  
####WRITING TRANSFER INTO A FUNCTION####
  #com=communicare var name mas=mastercare var name df= Mastercare dataframe(the appropriate one).
  Transfer.data <- function(Com,Mas,df){
    
    #deparse(substitute(Mas)) <- Com #this line is problematic #try name(Mas)<-Com   #try attach()?  #Mas<-DirectionsClinicalExtract[[Com]] #does com in [] work here?
    
    df<-cbind(Mas,df); 
  }

#####FUNCTION TEST ZONE####
  #inputs
   Com<-DirectionsClinicalExtract[["MOBILE.PHONE"]]
   # Mas<-"Mobile"
   df<-ClientDemographics_N
  #the function 
   Transfer.data(Com,Mas,df)
   Transfer.data("MOBILE.PHONE","Mobile",ClientDemographics_N) #test this
   View(df)  
   View(ClientDemographics_N)
  #current issue
  #ok so "Mobile"<-DirectionsClinicalExtract[["MOBILE.PHONE"]] works to create a var called Mobile with data required
  #however Mas<-"Mobile", then Mas <-DirectionsClinicalExtract[["MOBILE.PHONE"]] does not. It just puts the data in Mas. Is there a "rename variable" function?
  
   #1. Create dataframe for output
   ClientDemographics_N <-data.frame(matrix(NA, nrow = nrow(DirectionsClinicalExtract), ncol = ncol(ClientDemographics)))
   #2. Extract data into a variable
   PhoneBH<-DirectionsClinicalExtract[["PHONE"]]
   #3. Combine the dataframe and the variable, using the variable name we provided by default
   ClientDemographics_N<-cbind(PhoneBH,ClientDemographics_N); 
   #4. (optional??) Rename column to specific name
   names(ClientDemographics_N)[names(ClientDemographics_N) == "PhoneBH"] <- 'new.var.name' #setnames() from data.table package can also be used
        
        #function(x, y) {#uses argnames as labels
      #   plot(x, y, xlab = deparse(substitute(x)),
      #        ylab = deparse(substitute(y)))
      #   }
        

####EXPORTING####