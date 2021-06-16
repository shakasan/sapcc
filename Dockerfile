FROM centos:7
ARG SAPCC_VERSION=2.13.1
ARG SAPJVM_VERSION=8.1.075
WORKDIR /tmp/sapcc
#RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum -y install which unzip wget net-tools less sudo; yum clean all
RUN wget --no-check-certificate --no-cookies --header "Cookie: eula_3_1_agreed=tools.hana.ondemand.com/developer-license-3_1.txt; path=/;" -S https://tools.hana.ondemand.com/additional/sapcc-$SAPCC_VERSION-linux-x64.zip && \
    wget --no-check-certificate --no-cookies --header "Cookie: eula_3_1_agreed=tools.hana.ondemand.com/developer-license-3_1.txt; path=/;" -S https://tools.hana.ondemand.com/additional/sapjvm-$SAPJVM_VERSION-linux-x64.rpm && \
    unzip sapcc-$SAPCC_VERSION-linux-x64.zip && \
    rpm -i sapjvm-$SAPJVM_VERSION-linux-x64.rpm && \
    rpm -i com.sap.scc-ui-$SAPCC_VERSION-8.x86_64.rpm
RUN rm /tmp/sapcc/*.rpm
ENV JAVA_HOME=/opt/sapjvm_8/
#RUN chsh -s /bin/bash sccadmin
EXPOSE 8443
USER sccadmin
WORKDIR /opt/sap/scc
CMD ./go.sh
