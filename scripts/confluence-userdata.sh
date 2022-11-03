# Installs Confluence Server

function InstallConfluence {
positional_param=()
while [[ $# -gt 0 ]]; do
key="$1"
case $key in
--InstallPath)
confluence-install-path="$2"
shift
;;
--confluence-config)
confluence-config="$2"
shift
;;
*)
positional_param=("$1")
shift
;;
esac
shift
done
set -- "${positional_param[@]}"


cd /tmp
wget https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-7.20.1.tar.gz
#aws s3 sync $confluence-install-path  /tmp/
mkdir -p /opt/confluence
mkdir -p /opt/confluence-home
tar -xf /tmp/atlassian-confluence-*.tar.gz  -C /opt/confluence
$confluence_config="/opt/confluence/atlassian-confluence-7.20.0/confluence/WEB-INF/classes/confluence-init.properties"
if grep --quiet confluence.home=/opt/confluence-home/ ; then
    sed -i -e 's/\#confluence.home=\/var\/data\/confluence\//confluence.home=/opt/confluence.home/g' $confluence_config
fi
/opt/confluence/atlassian-confluence-*/bin/start-confluence.sh
}
InstallConfluence --InstallPath "s3://csw-packages/atlassian-confluence-7.20.0.tar.gz"

# Installs Confluence Server

function InstallConfluence {
positional_param=()
while [[ $# -gt 0 ]]; do
key="$1"
case $key in
--InstallPath)
confluence-install-path="$2"
shift
;;
--confluence-config)
confluence-config="$2"
shift
;;
*)
positional_param=("$1")
shift
;;
esac
shift
done
set -- "${positional_param[@]}"


cd /tmp
wget https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-7.20.1.tar.gz
#aws s3 sync $confluence-install-path  /tmp/
mkdir -p /opt/confluence
mkdir -p /opt/confluence-home
tar -xf /tmp/atlassian-confluence-*.tar.gz  -C /opt/confluence
$confluence_config_file="/opt/confluence/atlassian-confluence-7.20.0/confluence/WEB-INF/classes/confluence-init.properties"
sed -i -e 's/\#confluence.home=\/var\/data\/confluence\//confluence.home=/opt/confluence.home/g' $confluence_config_file
/opt/confluence/atlassian-confluence-*/bin/start-confluence.sh
}
InstallConfluence 


