FROM java:openjdk-7
# maint details
MAINTAINER Alexey Shumkin <alex.crezoff@gmail.com>
# system installations
RUN apt-get update && apt-get install -y wget
# product installations
RUN wget 'http://www.pmease.com/artifact?file=quickbuild-6.1.2.tar.gz&buildId=2960' -O quickbuild.tar && tar -zxvf quickbuild.tar -C /opt
# Expose the default QB port
EXPOSE 8810
# start quickbuild
ENTRYPOINT /opt/quickbuild-6.1.2/bin/server.sh console
