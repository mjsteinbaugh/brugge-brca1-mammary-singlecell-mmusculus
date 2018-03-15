wget http://www.broadinstitute.org/aspera/shares_download.txt
mv shares_download.txt ascp-shares-down.sh
chmod u+w ascp-shares-down.sh

#  To decrypt files, please set the  ASPERA_SCP_FILEPASS environemnt variable.
# 
#   Usage: bash local_target shares_url user:password /SHARES/PATH/TO/SOURCE/FILE
# 
#   Example: ascp-shares-down.sh /home/user/me/my_aspera_downloads https://shares.broadinstitute.org SN0000000:ABCD1234efgh /SN00000000/foo.bar

export ASPERA_SCP_FILEPASS="Y9DxHLyAoEtdV8c"

local_target="/n/data1/cores/bcbio/PIs/joan_brugge/brca1_mouse_mammary_scrnaseq/data-raw/SN0124793"
shares_url="https://shares.broadinstitute.org"
user="SN0124793"
password="JMIQGD14Q0LBD0O"

. ascp-shares-down.sh "$local_target" "$shares_url" "$user":"$password" "$user"/
