systemctl enable docker;
systemctl start docker;
sed -i '/NETCONFIG_DNS_POLICY/d' /etc/sysconfig/network/config;
sed -i '/NETCONFIG_DNS_STATIC_SERVERS/d' /etc/sysconfig/network/config;
sed -i '/NETCONFIG_DNS_STATIC_SEARCHLIST/d' /etc/sysconfig/network/config;
echo 'NETCONFIG_DNS_POLICY="STATIC"' >> /etc/sysconfig/network/config;
echo 'NETCONFIG_DNS_STATIC_SEARCHLIST="example.com"' >> /etc/sysconfig/network/config;
echo 'NETCONFIG_DNS_STATIC_SERVERS="18.142.61.31 172.26.0.2"' >> /etc/sysconfig/network/config;
netconfig update -f;


curl -s http://169.254.169.254/latest/meta-data

curl -s http://169.254.169.254/latest/user-data

curl -s http://169.254.169.254/latest/meta-data/public-ipv4
