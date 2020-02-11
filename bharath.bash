#!/bin/sh

# VARIABLES
source_path_price="/DEV/opt/assets/sap_process_files/Delivered/watersintegrationprices/prices"
source_path_others="/DEV/opt/assets/sap_process_files/Delivered/watersintegrationproductstatus/productstatus"
source_path_materialmaster="/DEV/opt/assets/sap_process_files/Delivered/watersintegrationsapproduct/materialmaster"
base_zerobyte_archive="/home/watuser/DEV_sap_zerobyte"
container_url="https://veve3kry1jr8hzudzeki2rc.blob.core.windows.net/hybris/master/hotfolder"
sas_token="?st=2019-12-05T16%3A21%3A53Z&se=2035-12-31T16%3A21%3A00Z&sp=rwl&sv=2018-03-28&sr=c&sig=wd0ppUPPBaSzGI4hNcm7e3fzCfChCkaRv1VhPst1OJc%3D"

# Get the zero byte files from multiple locations
#price-file
sudo find $source_path_price -type f -size 0 -exec mv {} $base_zerobyte_archive/price_zerobyte_archive \; >$base_zerobyte_archive/zero_byte_files.log

#status-file
sudo find $source_path_others -type f -size 0 -exec mv {} $base_zerobyte_archive/status_zerobyte_archive \; >>$base_zerobyte_archive/zero_byte_files.log

#material-master
sudo find $source_path_materialmaster -type f -size 0 -exec mv {} $base_zerobyte_archive/materialmaster_zerobyte_archive \; >>$base_zerobyte_archive/zero_byte_files.log

count=$(wc -l $base_zerobyte_archive/zero_byte_files.log)
result=$(cat $base_zerobyte_archive/zero_byte_files.log)


if [ $count -gt 0 ]; then
	echo " Below files is having 0 bytes...Please take necessary action..........."
	echo "------------------------------------------------------------------------"
	echo "$result"
	# Email logic goes here
else
	#copy from price files
#	azcopy sync "$source_path_price" "$container_url""$sas_token"
    echo "azcopy prices"

	#copy from other files
#	azcopy sync "$source_path_others" "$container_url""$sas_token"
echo "azcopy others"

	#copy from materialmaster
#	azcopy sync "$source_path_materialmaster" "$container_url""$sas_token"
echo "azcopy masters"
fi











