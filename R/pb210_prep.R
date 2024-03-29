pb_prep <- function(name, spike = 91.11, spike_error = 1, sampling_error = 1, thickness = 1){
  require(dplyr)
  require(lubridate)
  myDir <- paste0("plum_runs/",gsub(".csv", "", name), "/")
  myCSV <- paste0(myDir, name, ".csv")
  if(!dir.exists(myDir)) dir.create(myDir)
  data <- read.csv(name)
  data$thickness <- thickness

  data <- data %>%
    mutate(plate_date = dmy_hms(Plate_date),
           start_date = dmy_hms(Start_date),
           end_date = dmy_hms(End_date),
           int = plate_date %--% end_date,
           dur = as.duration(int)/dyears(1),
           po209 = Po209/(exp(-(log(2)/125 * dur))),
           po210 = Po210/(exp(-(log(2)/0.379112 * dur))),
           podiv = po210/po209,
           pb210_activity = podiv * spike/dry_weight,
           pb210_sd = pb210_activity * sqrt((Po209^0.5/Po209)^2+(Po210^0.5/Po210)^2+(spike_error/100)
                                            ^2 +(sampling_error/100)^2)) %>%
    rowid_to_column("labID") %>%
    select(bulk_density, depth, thickness, pb210_activity, pb210_sd, labID) %>%
    rename("density(g/cm^3)" = bulk_density, "depth(cm)" = depth,
           "210Pb(Bq/kg)" = pb210_activity, "sd(pb210)" = pb210_sd) %>%
    relocate(labID, "depth(cm)", "density(g/cm^3)", "depth(cm)", "210Pb(Bq/kg)", "sd(pb210)", thickness)
  write.csv(data, myCSV, row.names = F)}

