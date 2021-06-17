# CentOS7, as EoL is on 2024 ...
FROM centos:7
# SAPJVM and SAPCC version
# check https://tools.hana.ondemand.com/#cloud
ARG SAPCC_VERSION=2.13.1
ARG SAPJVM_VERSION=8.1.075
# working setup dir
WORKDIR /tmp/sapcc
# full update
RUN yum -y update && yum -y clean all
# add EPEL repo
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
# install some usefull tools
RUN yum -y install which unzip wget net-tools less sudo
# download the SAP JVM and SAPCC
RUN wget --no-check-certificate --no-cookies --header "Cookie: eula_3_1_agreed=tools.hana.ondemand.com/developer-license-3_1.txt; path=/;" -S https://tools.hana.ondemand.com/additional/sapcc-$SAPCC_VERSION-linux-x64.zip && \
    wget --no-check-certificate --no-cookies --header "Cookie: eula_3_1_agreed=tools.hana.ondemand.com/developer-license-3_1.txt; path=/;" -S https://tools.hana.ondemand.com/additional/sapjvm-$SAPJVM_VERSION-linux-x64.rpm && \
    unzip sapcc-$SAPCC_VERSION-linux-x64.zip && \
    rpm -i sapjvm-$SAPJVM_VERSION-linux-x64.rpm && \
    rpm -i com.sap.scc-ui-$SAPCC_VERSION-8.x86_64.rpm
# clean up previously installed rpm packages
RUN rm /tmp/sapcc/*.rpm
# set JAVA_HOME variable with the new SAP JVM
ENV JAVA_HOME=/opt/sapjvm_8/
# SAPCC Web Interface
EXPOSE 8443
# SAPCC user
USER sccadmin
# SAPCC working dir
WORKDIR /opt/sap/scc
# run SAPCC command
CMD ./go.sh
