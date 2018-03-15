wget http://www.broadinstitute.org/aspera/shares_download.txt
mv shares_download.txt ascp-shares-down.sh
chmod u+w ascp-shares-down.sh

#  To decrypt files, please set the  ASPERA_SCP_FILEPASS environemnt variable.
# 
#   Usage: bash LOCAL_TARGET SHARES_URL USER:PASSWORD /SHARES/PATH/TO/SOURCE/FILE
# 
#   Example: ascp-shares-down.sh /home/user/me/my_aspera_downloads https://shares.broadinstitute.org SN0000000:ABCD1234efgh /SN00000000/foo.bar

export ASPERA_SCP_FILEPASS="FwTAp0ZHLvt04hA"

LOCAL_TARGET="/n/data1/cores/bcbio/PIs/joan_brugge/brca1_mouse_mammary_scrnaseq/data-raw"
SHARES_URL="https://shares.broadinstitute.org"
USER="SN0122825"
PASSWORD="VGXF0K8SSL43XAV"

. ascp-shares-down.sh "$LOCAL_TARGET" "$SHARES_URL" "$USER":"$PASSWORD" "$USER"/
