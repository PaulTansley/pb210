Prep function for pb210 to get pb210 bq/kg and to organise and save data into correct format and file directory for Plum()

Runs with pb_prep(name, spike = 91.11, spike_error = 1, sampling_error = 1, thickness = 1)

name must be set the the name of the csv to be read in and must in quotes "". If csv is called peat_core_1 the name should be set to name = "peat_core_1" the function 
will then create a folder inside the Plum_runs directory, and save a formatted csv of the same name within that folder. 

spike must be set to the specific activity of the po209 spike(mBq) defaults to 91.11

spike_error defaults to 1 change where necessary 

sampling_error defaults to 1, change where necessary

thickness of sub sample defaults to 1 change if necessary 

columns should be labeled as below: all dates should be in the format dd/mm/yyyy hh:mm:ss
depth	  bulk_density  	dry_weight  	plate_date  	Po209 	Po210 	start_date  	end_date


install.packages(devtools)
devtoolS::install_github(PaulTansley/pb210)
