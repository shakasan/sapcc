# -----------------------------------------------------------------------------
# SAP Cloud Connector Dockerfile
#   Author : Francois B (Makoto)
#   Github : https://github.com/shakasan/sapcc
#   Docker Hub : https://hub.docker.com/r/makoto2600/sapcc
#   Licence : GPLv3
# -----------------------------------------------------------------------------

# CentOS7, as EoL is on 2024 ...
FROM centos:7

# SAPJVM and SAPCC version
# check https://tools.hana.ondemand.com/#cloud
ARG SAPCC_VERSION=2.14.0
ARG SAPJVM_VERSION=8.1.083

# working setup dir
WORKDIR /tmp/sapcc

# full update + add EPEL repo + install some useful tools
RUN yum -y update && yum -y clean all && \
    yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum -y install which unzip wget net-tools less sudo

# download the SAP JVM and SAPCC
RUN wget --no-check-certificate --no-cookies --header "Cookie: eula_3_1_agreed=tools.hana.ondemand.com/developer-license-3_1.txt; path=/;" -S https://tools.hana.ondemand.com/additional/sapcc-$SAPCC_VERSION.1-linux-x64.zip && \
    wget --no-check-certificate --no-cookies --header "Cookie: eula_3_1_agreed=tools.hana.ondemand.com/developer-license-3_1.txt; path=/;" -S https://tools.hana.ondemand.com/additional/sapjvm-$SAPJVM_VERSION-linux-x64.rpm && \
    unzip sapcc-$SAPCC_VERSION.1-linux-x64.zip && \
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
