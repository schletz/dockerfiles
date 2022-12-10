#!/bin/bash
# Useage: ldap_config.sh basedn root_password
# https://unix.stackexchange.com/questions/362547/automating-slapd-install

admin_user=cn=admin,dc=${1/./,dc=}  # Convert company.local to cn=admin,dc=company,dc=local

echo -e "slapd slapd/root_password password $2" |debconf-set-selections
echo -e "slapd slapd/root_password_again password $2" |debconf-set-selections
echo -e "slapd slapd/internal/adminpw password $2" |debconf-set-selections
echo -e "slapd slapd/internal/generated_adminpw password $2" |debconf-set-selections
echo -e "slapd slapd/password2 password $2" |debconf-set-selections
echo -e "slapd slapd/password1 password $2" |debconf-set-selections
echo -e "slapd slapd/domain string $1" |debconf-set-selections
echo -e "slapd shared/organization string ${1/.*/}" |debconf-set-selections
echo -e "slapd slapd/backend string HDB" |debconf-set-selections
echo -e "slapd slapd/purge_database boolean true" |debconf-set-selections
echo -e "slapd slapd/move_old_database boolean true" |debconf-set-selections
echo -e "slapd slapd/allow_ldap_v2 boolean false" |debconf-set-selections
echo -e "slapd slapd/no_configuration boolean false" |debconf-set-selections
dpkg-reconfigure -f noninteractive slapd &> /dev/null

sed -i "s/cn=admin,cn=config/$admin_user/g" /etc/ldap/slapd.d/cn\=config/olcDatabase\=\{0\}config.ldif
slapd -h ldap://:1389/ && ldapadd -H ldap://localhost:1389 -x -w LdapPassword -D "$admin_user" -f /tmp/users.ldif
