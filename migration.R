#I changed the first line to test my git thingo.

#data migration for Directions from Communicare to Mastercare
#goal: identify which variables in communicare data output csv map to which variables in mastercare input (multiple) csv's
#then write a script to cut and paste from one to the other, while retaining the original format of the mastercare input csv's

#thougths. I think I need to find a way to do structures in R. That way I can structure each seperate mastercare variable to link it to it's
#source csv. This will also make writing to file much easier in the end.

##import all -> name cleverly -> recode/reformat inappropriate data -> transfer data from C to M -> export, matching origin format

##import all input templates (jonPC specific)
 # Appointment <- read.csv("C:/Users/Owner/Dropbox/job stuff/Directions/Data migration/Import templates & data dictionary/Appointment.csv")
 #   View(Appointment)
 # ClientDemographics <- read.csv("C:/Users/Owner/Dropbox/job stuff/Directions/Data migration/Import templates & data dictionary/ClientDemographics.csv", header=TRUE)
 #   View(ClientDemographics)
 # ClientGP <- read.csv("C:/Users/Owner/Dropbox/job stuff/Directions/Data migration/Import templates & data dictionary/ClientGP.csv")
 #   View(ClientGP)
 # ClientOtherLanguage <- read.csv("C:/Users/Owner/Dropbox/job stuff/Directions/Data migration/Import templates & data dictionary/ClientOtherLanguage.csv")
 #   View(ClientOtherLanguage)
 # FamilyHistory <- read.csv("C:/Users/Owner/Dropbox/job stuff/Directions/Data migration/Import templates & data dictionary/FamilyHistory.csv")
 #   View(FamilyHistory)
 # GP <- read.csv("C:/Users/Owner/Dropbox/job stuff/Directions/Data migration/Import templates & data dictionary/GP.csv", header=TRUE)
 #   View(GP)
 # ClientDemographics <- read.csv("C:/Users/Owner/Dropbox/job stuff/Directions/Data migration/Import templates & data dictionary/ClientDemographics.csv", header=TRUE)
 #   View(ClientDemographics)
 # HealthCareCard <- read.csv("C:/Users/Owner/Dropbox/job stuff/Directions/Data migration/Import templates & data dictionary/HealthCareCard.csv")
 #   View(HealthCareCard)
 # ICD10 <- read.csv("C:/Users/Owner/Dropbox/job stuff/Directions/Data migration/Import templates & data dictionary/ICD10.csv")
 #   View(ICD10)
 # ICPC <- read.csv("C:/Users/Owner/Dropbox/job stuff/Directions/Data migration/Import templates & data dictionary/ICPC.csv")
 #   View(ICPC)
 # NOK <- read.csv("C:/Users/Owner/Dropbox/job stuff/Directions/Data migration/Import templates & data dictionary/NOK.csv", header=TRUE)
 #   View(NOK)
 # Referral <- read.csv("C:/Users/Owner/Dropbox/job stuff/Directions/Data migration/Import templates & data dictionary/Referral.csv")
 #   View(Referral)
 # Referral_BoiMH <- read.csv("C:/Users/Owner/Dropbox/job stuff/Directions/Data migration/Import templates & data dictionary/Referral_BoiMH.csv", header=TRUE)
 #   View(Referral_BoiMH)
 # Session <- read.csv("C:/Users/Owner/Dropbox/job stuff/Directions/Data migration/Import templates & data dictionary/Session.csv")
 #   View(Session)
 # Staff <- read.csv("C:/Users/Owner/Dropbox/job stuff/Directions/Data migration/Import templates & data dictionary/Staff.csv")
 #   View(Staff)
 # StaffTeam <- read.csv("C:/Users/Owner/Dropbox/job stuff/Directions/Data migration/Import templates & data dictionary/StaffTeam.csv")
 #   View(StaffTeam)
 # Team <- read.csv("C:/Users/Owner/Dropbox/job stuff/Directions/Data migration/Import templates & data dictionary/Team.csv")
   # View(Team)
   
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
   
   DirectionsClinicalExtract <- read.csv("C:/Users/Owner/Dropbox/job stuff/Directions/Data migration/DirectionsClinicalExtract.csv")
     View(DirectionsClinicalExtract)

#identifying data that needs to be migrated and is translatable
     #getting list of all variables in the communicare data
     
    Communicare.names <-names(DirectionsClinicalExtract)
#this shows that there are 276 variables to home into Mastercare
    
#now select vital data and subdivide this into a new dataset

    #chop away columns that have no data and list their name
    #identify them
    Dir_isempty<-sapply(DirectionsClinicalExtract, function(x)all(is.na(x)))
    Dir_Names_emptycols <- names(Dir_isempty[Dir_isempty>0]) #this grabs the TRUEs
    print("the columns with all values missing")
    print(Dir_Names_emptycols)
#this shows that there are 106 columns that are empty and can be removed
    
    Dir_Names_usedcols <- names(Dir_isempty[Dir_isempty<1]) #this is all columns with data
    print("the columns that contain data")
    print(Dir_Names_usedcols)
#this shows there are 170 columns with data 
    
#new dataset with all emptycols removed
    Communicare <- DirectionsClinicalExtract[Dir_Names_usedcols]
    
#manual inspection of remaining data to remove useless feilds
    write.csv(Communicare, file = "Communicare.csv") #file creation for easier browsing. Switch off if rerunning script
    
#some likely useless fields below (there are definitely more)
    #CREATED.DATE is used only when PAT.MORB.DESC field is used (which is v rarely)
    #RECALL.INTERVAL is just preset durations. Almost all the same
    #CREATED.USER is all "SYSDBA". Presumably referring to the fact it was made by an admin. A few refer to staff
    #CREATED.TIMESTAMP refers to CREATED.USER is all basically the same. Only different when made by staff
    #AGE.TITLE.TODAY is not something we would want to migrate as their age will change and Mastercare will surely calculate this from DOB
    #MISSED.APPOINTMENT.RISK I'm quite sure refers to a tickbox in Communicare which may not exist in Mastercare'
    
#congregation of definitely vital data
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
   
    
#setting up lists of variable names    
    Communicare_Vital_N<-names(Communicare_Vital)
    Communicare_useful_N<-names(Communicare_useful)
    
#All remaining non-useful data by subracting the two useful sets from the full communicare set (still excluding the empty columns) 
   Communicare_trash <- Communicare[ , !(names(Communicare) %in% c(Communicare_Vital_N,Communicare_useful_N))] 
  
  
#save all to csv.
  write.csv(Communicare_Vital, file = "Communicare_Vital.csv")
  write.csv(Communicare_useful, file = "Communicare_useful.csv")
  write.csv(Communicare_trash, file = "Communicare_trash.csv")  
  
  
#finding and sending to appropriate homes in Mastercare for the data
#transforming data to appropriate formats where required
  
  #Data transfer template
ClientDemographics$Sex <- rbind(ClientDemographics$Sex,DirectionsClinicalExtract$PAT.SEX)     #notworking
  
  
  
  #vital data
  "PAT.ID", #ALL
  "PAT.SEX",ClientDemographics
  "DATE.OF.BIRTH", ClientDemographics
  "PAT.HDWA.MRN", #SLK #ALL
  "MEDICARE.NO", HealthCareCard
  "MEDICARE.REF.NO",HealthCareCard
  "MEDICARE.EXPIRY",HealthCareCard
  "OLD.PENSION.NO",HealthCareCard
  "FORENAMES",ClientDemographics
  "SURNAME",ClientDemographics
  "ADDR.1",ClientDemographics
  "ADDR.2",ClientDemographics
  "PHONE",ClientDemographics
  "KIN.NAME1",NOK
  "BIRTHPLACE",ClientDemographics
  "MOBILE.PHONE",ClientDemographics
  "WORK.PHONE",ClientDemographics
  "EMERGENCY.CONTACT.NAME",NOK
  "EMERGENCY.CONTACT.PHONE",NOK
  "HCC.EXPIRY",HealthCareCard
  "FULL.NAME",ClientDemographics
  "ABORIGINAL",ClientDemographics
  "CRN.NO")]HealthCareCard
  
  #maybe useful data
 "SERVICE.PROVIDER.NO",GP, Staff
 "MORB.TYPE.SHORT.DESC",
 "MORB.TYPE.SHORT.DESC.UC",
 "SYS.CODE",
 "ICPC.CODE", ICPC
 "NAT.LAN.TERM",
 "MORB.RIGHT.NO",
 "PREG.COMPLICATION",nowhere
 "UNIQUE.ID",ALL? Redundant?
 "PAT.ID.1",ALL? Redundant?
 "LOCALITY.NO",ClientDemographics
 "AB.TYPE.NO",
 "KIN.TYPE1",NOK?
 "CURRENT.STATUS",
 "EMERGENCY.CONTACT.TYPE",NOK
 "HIC.BULK.ELIGIBLE", nowhere
 "FIRST.FORENAME",ClientDemographics redundant?
 "MARITAL.STATUS.NO",ClientDemographics
 "LANGUAGE.NO",ClientDemographics & maybe ClientOtherLanguage
 "BIRTH.CTRY.NO",ClientDemographics (redundant?)
 "CENTRELINK.TYPE.CODE",
 "HCC.NO", HealthCareCard redundant #doubled up with CRN.NO
 "DOB.ESTIMATED", nowhere #t/f tickbox
 "HIC.ELIGIBILITY.LAST.CHECKED", nowhere
 "NTHC.SEND.DRUG.ALLERGY",nowhere
 "LANGUAGE.HOME.NO",ClientDemographics
 "NO.KNOWN.REACTIONS", nowhere
 "CTG.REGISTERED",
 "BP.IMPORTED.PAT.ID", nowhere
 "PREFERRED.CONTACT",ClientDemographics or nowhere
 "HAS.NO.PHONE", nowhere
 "RECORD.STORAGE.SITE.NO", nowhere
 "HIC.BULK.BILL",
 "HIC.CLAIM.STATUS",
 "HIC.DB4.PRINTED",
 "HIC.NON.CLAIMABLE",
 "REASON.MORB.NO",
 "PROVIDER.NO.1", ClientGP, GP?
 "SPECIALITY.TYPE.NO", ClientGP, GP?
 "D.GENDER", ClientGP, GP? #dr gender? 
 "DOH.PRESCRIBER.NO", GP
 "QUALIFICATIONS", nowhere
 "TITLE", ClientGP, GP?#of dr
 "BP.USERID")] nowehere
   

   
   
#exporting Mastercare in same format as recieved.   