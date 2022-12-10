# Create an image with OpenLDAP
# docker build -t openldap . --build-arg basedn=mycompany.local --build-arg root_password=LdapPassword
# docker run -d -p 1389:1389  --name openldap openldap 
FROM ubuntu:22.04
ARG basedn=mycompany.local
ARG root_password=LdapPassword

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y slapd ldap-utils
COPY users.ldif /tmp
COPY ldap_config.sh /tmp

RUN chmod a+x /tmp/ldap_config.sh
RUN /tmp/ldap_config.sh $basedn $root_password

EXPOSE 1389
CMD slapd -h ldap://:1389/ -d 0
