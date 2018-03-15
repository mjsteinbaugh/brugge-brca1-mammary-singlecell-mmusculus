wget http://www.broadinstitute.org/aspera/shares_download.txt
mv shares_download.txt ascp-shares-down.sh
chmod u+w ascp-shares-down.sh

#  To decrypt files, please set the  ASPERA_SCP_FILEPASS environemnt variable.
# 
#   Usage: bash local_target shares_url user:password /SHARES/PATH/TO/SOURCE/FILE
# 
#   Example: ascp-shares-down.sh /home/user/me/my_aspera_downloads https://shares.broadinstitute.org SN0000000:ABCD1234efgh /SN00000000/foo.bar

export ASPERA_SCP_FILEPASS="FQZeYyMU0IUmg9W"

local_target="/n/data1/cores/bcbio/PIs/joan_brugge/brca1_mouse_mammary_scrnaseq/data-raw/full_outs"
shares_url="https://shares.broadinstitute.org"
user="SN0124067"
password="LHVY2X8YVNI95IP"

. ascp-shares-down.sh "$local_target" "$shares_url" "$user":"$password" "$user"/
