FROM java:openjdk-7
# maint details
MAINTAINER Alexey Shumkin <alex.crezoff@gmail.com>
# system installations
RUN apt-get update \
    && apt-get install -y wget less vim \
    && rm -rf /var/lib/apt/lists/*
# set Moscow timezone
RUN ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
# set env vars
# Quickbuild
ENV QUICKBUILD_VERSION=6.1.3
ENV QUICKBUILD_BUILD_ID=2964
ENV QUICKBUILD=quickbuild-${QUICKBUILD_VERSION}
ENV QUICKBUILD_GZ_FILE=quickbuild.tar.gz
ARG QUICKBUILD_DOWNLOAD_URL=https://www.pmease.com/artifacts/${QUICKBUILD_BUILD_ID}/${QUICKBUILD}.tar.gz

# MySQL connector plugin
ENV MYSQL_CONNECTOR_LIB_VERSION=5.1.38
ENV MYSQL_CONNECTOR_LIB=mysql-connector-java-${MYSQL_CONNECTOR_LIB_VERSION}
ENV MYSQL_CONNECTOR_LIB_GZ_FILE=${MYSQL_CONNECTOR_LIB}.tar.gz
ARG MYSQL_CONNECTOR_LIB_DOWNLOAD_URL=http://dev.mysql.com/get/Downloads/Connector-J/${MYSQL_CONNECTOR_LIB_GZ_FILE}

# product installations
RUN wget --no-verbose "${QUICKBUILD_DOWNLOAD_URL}" -O ${QUICKBUILD_GZ_FILE} \
    && tar -zxvf ${QUICKBUILD_GZ_FILE} -C /opt \
    && rm ${QUICKBUILD_GZ_FILE}
# install MySQL library
# download, unpack binary JAR, copy with rename to plugins directory
RUN wget --no-verbose "${MYSQL_CONNECTOR_LIB_DOWNLOAD_URL}" -O ${MYSQL_CONNECTOR_LIB_GZ_FILE} \
    && tar -zxvf ${MYSQL_CONNECTOR_LIB_GZ_FILE} ${MYSQL_CONNECTOR_LIB}/${MYSQL_CONNECTOR_LIB}-bin.jar --strip-components=1 \
    && cp -av ${MYSQL_CONNECTOR_LIB}-bin.jar /opt/${QUICKBUILD}/plugins/com.pmease.quickbuild.libs/${MYSQL_CONNECTOR_LIB}.jar \
    && rm ${MYSQL_CONNECTOR_LIB_GZ_FILE} ${MYSQL_CONNECTOR_LIB}-bin.jar
# add config files
ADD *.properties /opt/${QUICKBUILD}/conf/
# Expose the default QB port
EXPOSE 8810
# start quickbuild
ENTRYPOINT /opt/${QUICKBUILD}/bin/server.sh console
