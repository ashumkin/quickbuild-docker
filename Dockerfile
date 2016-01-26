FROM java:openjdk-7
# maint details
MAINTAINER Alexey Shumkin <alex.crezoff@gmail.com>
# system installations
RUN apt-get update \
    && apt-get install -y wget less vim \
    && rm -rf /var/lib/apt/lists/*
# product installations
RUN wget 'http://www.pmease.com/artifact?file=quickbuild-6.1.2.tar.gz&buildId=2960' -O quickbuild.tar && tar -zxvf quickbuild.tar -C /opt
# install MySQL library
# download, unpack binary JAR, copy with rename to plugins directory
RUN wget 'http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.38.tar.gz' -O mysql-connector-java-5.1.38.tar.gz \
    && tar -zxvf mysql-connector-java-5.1.38.tar.gz mysql-connector-java-5.1.38/mysql-connector-java-5.1.38-bin.jar --strip-components=1 \
    && cp -av mysql-connector-java-5.1.38-bin.jar /opt/quickbuild-6.1.2/plugins/com.pmease.quickbuild.libs/mysql-connector-java-5.1.38.jar
# add config files
ADD *.properties /opt/quickbuild-6.1.2/conf/
# Expose the default QB port
EXPOSE 8810
# start quickbuild
ENTRYPOINT /opt/quickbuild-6.1.2/bin/server.sh console
