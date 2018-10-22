#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Quick slices of the processed ODOT crash data
# https://github.com/danieldn/vision-zero-pdx/blob/master/DataWithGEO.csv
# that was added by Ray to the repo. Field names, translations taken from or
# guessed based on
# https://gis.odot.state.or.us/arcgis/rest/services/transgis/data_catalog_display/MapServer/layers
# Primary function was to convert list of fields Chen used
# https://github.com/danieldn/vision-zero-pdx/blob/master/variable%20def%20and%20tree%20sample.docx
# to fields in the real dataset from ODOT.

# Libraries loaded:
  library(dplyr)
  library(data.table)
  library(ggplot2)
  library(stats)
  library(stringr)
  library(tidyr)
  # library(lubridate)
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


# = = = = = = = = = = = = =[ READ IN DATA ]= = = = = = = = = = = = = = = = = =
dir_path=paste0('Desktop/hack/')
crash_data<-read.csv(paste0(dir_path,'DataWithGEO.xlsx'),sep=',')
View(names(crash_data))


crash_data_sub<-dplyr::select(crash_data,
                                
  #--------------------------[ CRASH SEVERITY ]-------------------------------                                             
  CRASH_SVRTY_CD,                   #"Crash Severity Code"
  CRASH_SVRTY_SHORT_DESC,           #"Crash Severity Desc"
  
  #----------------------------[ FATAL COUNT ]--------------------------------
  TOT_FATAL_CNT,                    #"Total Deaths"
  # TOT_PED_FATAL_CNT,              #"Total Pedestrian Deaths"
  # TOT_PEDCYCL_FATAL_CNT,          #"Total Pedal-cyclist Deaths"
  # TOT_PSNGR_VHCL_OCC_UNRESTRND_FATAL_CNT, #NAs
  # TOT_ALCHL_IMPAIRED_DRVR_INV_FATAL_CNT, #NAs
  # TOT_UNKNWN_FATAL_CNT,           #"Total Unknown Non-Motorist Deaths"
  
  #---------------------------[ INJURY COUNT ]--------------------------------
  TOT_INJ_CNT,                      #"Total Non-Fatal Injuries"
  # TOT_INJ_LVL_A_CNT,              #"Total Serious Injuries"
  # TOT_PEDCYCL_INJ_LVL_A_CNT,      #"Total Pedal-cyclist Serious Injuries"
  # TOT_PED_INJ_LVL_A_CNT,          #"Total Pedestriann Serious Injuries"
  # TOT_INJ_LVL_B_CNT,              #"Total Moderate Injuries"
  # TOT_INJ_LVL_C_CNT,              #"Total Minor Injuries"
  # TOT_PED_INJ_CNT,                #"Total Pedestrian Injuries"
  # TOT_PEDCYCL_INJ_CNT,            #"Total Pedal-Cyclists"
  # TOT_UNKNWN_INJ_CNT,             #"Total Unknown Non-Motorist Injured"
  
  #----------------------[ MEDIAN SPEED OF VEHICLES ]-------------------------
  
  #------------------------[ COUNT OF MOVING CARS ]---------------------------
  TOT_VHCL_CNT,                     #"Total Vehicles"
  
  #------------------------[ COUNT OF PEDESTRIANS ]---------------------------
  TOT_PED_CNT,                      #"Total Pedestrians"
  
  #--------------------------[ ROADWAY NUMBER  ]------------------------------
  ST_FULL_NM,                       #"Street Name"
  # ISECT_SEQ_NO,                   #"Intersection Sequence No", #NAs
  
  #-----------------------------[ ROADWAY TYPE ]------------------------------
  
  #-----------------------------[ # OF LANES ]--------------------------------
  # LN_QTY                          #"Number of Lanes", #NAs
  
  #-------------------------------[ WEATHER ]---------------------------------
  WTHR_COND_SHORT_DESC,             #"Weather Desc"
  
  #---------------------------------[ ROAD ]----------------------------------
  RD_SURF_COND_CD,                  #"Road Surface Condition"
  
  #----------------------------------[ TIME ]---------------------------------
  CRASH_HR_NO,                      #"CRASH Hour"
  
  #---------------------------------[ REGION ]--------------------------------
  URB_AREA_CD,                      #"Urban Area"
  URB_AREA_SHORT_NM,                #"Urban Area Name"
  
  #---------------------------------[ PARKING ]-------------------------------
  
  #----------------------------[ SIDE OF COLLISION ]--------------------------
  COLLIS_TYP_CD,                    #"Collision Type Code"
  COLLIS_TYP_SHORT_DESC,            #"Collision Type Desc"
  
  #---------------------------------[ MORE... ]-------------------------------
  # FROM_ISECT_DSTNC_QTY,           #"Distance from Intersection" #NAs
  IMPCT_LOC_CD,                     #"Location of Impact"
  ALCHL_INVLV_FLG,                  #"Alcohol Involved Flag"
  DRUG_INVLV_FLG,                   #"Drug Involved Flag"
  
  TOT_UNINJD_AGE00_04_CNT,          #"Total Un-injured Age 00-04"
  TOT_UNINJD_PER_CNT,               #"Total Un-injured Persons"
  
  TOT_PEDCYCL_CNT,                  #"Total Pedal-cyclists"
  TOT_UNKNWN_CNT,                   #"Total Unknown Non-Motorists"
  TOT_OCCUP_CNT,                    #"Total Vehicle Occupants"
  TOT_PER_INVLV_CNT,                #"Total Persons Involved"
  
  CRASH_DT,                         #"CRASH Date"              
  CRASH_MO_NO,                      #"CRASH Month"
  CRASH_DAY_NO,                     #"CRASH Day"
  CRASH_YR_NO,                      #"CRASH Year"
  CRASH_WK_DAY_CD                   #"Day of Week"

)%>%filter(
  
  #-----------------------------[ CRASH SEVERITY ]----------------------------                                            
  !is.na(CRASH_SVRTY_CD),   
  !is.na(CRASH_SVRTY_SHORT_DESC),
  
  #------------------------------[ FATAL COUNT ]------------------------------
  !is.na(TOT_FATAL_CNT),
  # !is.na(TOT_PED_FATAL_CNT),
  # !is.na(TOT_PEDCYCL_FATAL_CNT),
  # !is.na(TOT_PSNGR_VHCL_OCC_UNRESTRND_FATAL_CNT),
  # !is.na(TOT_ALCHL_IMPAIRED_DRVR_INV_FATAL_CNT),
  # !is.na(TOT_UNKNWN_FATAL_CNT),
  
  #-----------------------------[ INJURY COUNT ]------------------------------
  !is.na(TOT_INJ_CNT),
  # !is.na(TOT_INJ_LVL_A_CNT),
  # !is.na(TOT_PEDCYCL_INJ_LVL_A_CNT),
  # !is.na(TOT_PED_INJ_LVL_A_CNT),
  # !is.na(TOT_PEDCYCL_INJ_LVL_A_CNT),
  # !is.na(TOT_INJ_LVL_B_CNT),
  # !is.na(TOT_INJ_LVL_C_CNT),
  # !is.na(TOT_PED_INJ_CNT),
  # !is.na(TOT_PEDCYCL_INJ_CNT),
  
  #---------------------[ MEDIAN SPEED OF VEHICLES ]--------------------------
  
  #-----------------------[ COUNT OF MOVING CARS ]----------------------------
  !is.na(TOT_VHCL_CNT),
  
  #-----------------------[ COUNT OF PEDESTRIANS ]----------------------------
  !is.na(TOT_PED_CNT),
  
  #-------------------------[ ROADWAY NUMBER  ]-------------------------------
  !is.na(ST_FULL_NM),
  # !is.na(ISECT_SEQ_NO),
  
  #---------------------------[ ROADWAY TYPE ]--------------------------------
  !is.na(ST_FULL_NM),
  
  #-----------------------------[ # OF LANES ]--------------------------------
  # !is.na(LN_QTY),
  
  #-------------------------------[ WEATHER ]---------------------------------
  !is.na(WTHR_COND_SHORT_DESC),
  
  #---------------------------------[ ROAD ]----------------------------------
  !is.na(RD_SURF_COND_CD),
  
  #---------------------------------[ TIME ]----------------------------------
  !is.na(CRASH_HR_NO),
  
  #--------------------------------[ REGION ]---------------------------------
  !is.na(URB_AREA_CD),
  !is.na(URB_AREA_SHORT_NM),
  
  #-------------------------------[ PARKING ]---------------------------------
  
  #---------------------------[ SIDE OF COLLISION ]---------------------------
  !is.na(COLLIS_TYP_CD),
  !is.na(COLLIS_TYP_SHORT_DESC)
  
  #--------------------------------[ MORE... ]--------------------------------
  # !is.na(FROM_ISECT_DSTNC_QTY),
  # !is.na(IMPCT_LOC_CD),
  # !is.na(ALCHL_INVLV_FLG),                       
  # !is.na(DRUG_INVLV_FLG),
  #
  # !is.na(TOT_UNINJD_AGE00_04_CNT),
  # !is.na(TOT_UNINJD_PER_CNT), 
  # 
  # !is.na(TOT_PEDCYCL_CNT),
  # !is.na(TOT_UNKNWN_CNT),    
  # !is.na(TOT_UNKNWN_INJ_CNT),
  # !is.na(TOT_OCCUP_CNT),
  # !is.na(TOT_PER_INVLV_CNT),
  # !is.na(TOT_PED_INJ_LVL_A_CNT),
  # 
  # !is.na(TOT_PSNGR_VHCL_OCC_UNRESTRND_FATAL_CNT),
  # !is.na(TOT_ALCHL_IMPAIRED_DRVR_INV_FATAL_CNT),
  # 
  # !is.na(CRASH_DT),                  
  # !is.na(CRASH_MO_NO),
  # !is.na(CRASH_DAY_NO),
  # !is.na(CRASH_YR_NO),                      
  # !is.na(CRASH_WK_DAY_CD)
)
View(crash_data_sub)


#------------------------[ CRASHES BY YEAR ]----------------------------------
ggplot(data=crash_data_sub)+
  geom_bar(aes(x=CRASH_YR_NO),stat='count')+
  scale_x_continuous(breaks=seq(2006,2015))+
  labs(x="year",y="",title="Numbers of Crashes")

crashes_by_yr<-data.table(crash_data_sub%>%
  group_by(CRASH_YR_NO)%>%
    summarize(
      total=n(),
      avg_deaths=mean(TOT_FATAL_CNT)
    )
  )
crashes_by_yr


#------------------------[ CRASHES BY MONTH AND HOUR ]------------------------
crashes_by_mo_hr<-data.table(crash_data_sub%>%
   filter(CRASH_HR_NO<=24)%>%
   group_by(CRASH_MO_NO,CRASH_HR_NO)%>%
   summarize(
     total=n(),
     avg_deaths=mean(TOT_FATAL_CNT)
   )
)
ggplot(crashes_by_mo_hr)+geom_tile(aes(x=CRASH_MO_NO, y=CRASH_HR_NO,fill=total))+
scale_x_continuous(breaks=seq(1,12))+
scale_y_continuous(breaks=seq(0,23))+
labs(x="month",y="hour",title="Total crashes")

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%