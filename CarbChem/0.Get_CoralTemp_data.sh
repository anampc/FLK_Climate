#!/bin/bash

# Obtain SST data from NOAA OI SST V2 High Resolution Dataset
# Needs ~XXX of free sapce 

# Get the climatology data from ftp://ftp.star.nesdis.noaa.gov/pub/sod/mecb/crw/data/5km/v3.1/climatology/nc/
        cd Data/
        wget ftp://ftp.star.nesdis.noaa.gov/pub/sod/mecb/crw/data/5km/v3.1/climatology/nc/ct5km_climatology_v3.1.nc ./
        cd ..

# Make and navegate to the OISST folder
	mkdir Daily_CoralTemp_3.1
	cd Daily_CoralTemp_3.1/


# Get the SST data from ftp://ftp.star.nesdis.noaa.gov/pub/sod/mecb/crw/data/coraltemp/v3.1/nc/
wget ftp://ftp.star.nesdis.noaa.gov/pub/sod/mecb/crw/data/coraltemp/v3.1/nc/2009/*.nc ./
wget ftp://ftp.star.nesdis.noaa.gov/pub/sod/mecb/crw/data/coraltemp/v3.1/nc/2010/*.nc ./
wget ftp://ftp.star.nesdis.noaa.gov/pub/sod/mecb/crw/data/coraltemp/v3.1/nc/2011/*.nc ./
wget ftp://ftp.star.nesdis.noaa.gov/pub/sod/mecb/crw/data/coraltemp/v3.1/nc/2012/*.nc ./
wget ftp://ftp.star.nesdis.noaa.gov/pub/sod/mecb/crw/data/coraltemp/v3.1/nc/2013/*.nc ./
wget ftp://ftp.star.nesdis.noaa.gov/pub/sod/mecb/crw/data/coraltemp/v3.1/nc/2014/*.nc ./
wget ftp://ftp.star.nesdis.noaa.gov/pub/sod/mecb/crw/data/coraltemp/v3.1/nc/2015/*.nc ./
wget ftp://ftp.star.nesdis.noaa.gov/pub/sod/mecb/crw/data/coraltemp/v3.1/nc/2016/*.nc ./
wget ftp://ftp.star.nesdis.noaa.gov/pub/sod/mecb/crw/data/coraltemp/v3.1/nc/2017/*.nc ./
wget ftp://ftp.star.nesdis.noaa.gov/pub/sod/mecb/crw/data/coraltemp/v3.1/nc/2018/*.nc ./
wget ftp://ftp.star.nesdis.noaa.gov/pub/sod/mecb/crw/data/coraltemp/v3.1/nc/2019/*.nc ./
wget ftp://ftp.star.nesdis.noaa.gov/pub/sod/mecb/crw/data/coraltemp/v3.1/nc/2020/*.nc ./
wget ftp://ftp.star.nesdis.noaa.gov/pub/sod/mecb/crw/data/coraltemp/v3.1/nc/2021/*.nc ./

