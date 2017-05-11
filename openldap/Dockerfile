FROM centos:7.3.1611
MAINTAINER lx,lx.simon@yahoo.com

ENV CURDIR /opt/scripts
RUN yum update -y && yum install -y vim openssh openssh-clients openssh-server openldap openldap-clients openldap-servers openldap-servers-sql pacemaker
RUN sed -i 's/com/cn/g' '/etc/openldap/slapd.d/cn=config/olcDatabase={2}hdb.ldif'
RUN sed -i 's/my-domain/btadmin/g' '/etc/openldap/slapd.d/cn=config/olcDatabase={2}hdb.ldif'
RUN sed -i 's/com/cn/g' '/etc/openldap/slapd.d/cn=config/olcDatabase={1}monitor.ldif'
RUN sed -i 's/my-domain/btadmin/g' '/etc/openldap/slapd.d/cn=config/olcDatabase={1}monitor.ldif'
RUN echo "olcRootPW: `slappasswd -h {MD5} -s "baituldap"`" >> '/etc/openldap/slapd.d/cn=config/olcDatabase={2}hdb.ldif'
ADD scripts ${CURDIR}
WORKDIR ${CURDIR}
EXPOSE 389
VOLUME [ "/var/lib/ldap" ]
ENTRYPOINT ["./ldap-entrypoint.sh"]
CMD [ "slapd", "-d", "256" ]

