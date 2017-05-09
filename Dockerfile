# Use latest jboss/base-jdk:8 image as the base
FROM jboss/base-jdk:8

MAINTAINER Arthur Fayzullin <arthur.fayzullin@gmail.com>

# Update image
USER root
RUN yum -y upgrade && \
    yum clean all
USER jboss

# Set environment
ENV JBOSS_HOME /opt/jboss/wildfly-10.0.0
ENV LAUNCH_JBOSS_IN_BACKGROUND true
ENV LIFERAY_VERSION "7.0.2 GA3"
ENV LIFERAY_VERSION_FULL "7.0-ga3-20160804222206210"
ENV LIFERAY_SHA1 56d276c720ac026a58ccea7c1ed307620d6ca91d

# Liferay instalation
RUN cd $HOME && \
    curl -L -O "http://downloads.sourceforge.net/project/lportal/Liferay Portal/$LIFERAY_VERSION/liferay-ce-portal-wildfly-$LIFERAY_VERSION_FULL.zip" && \
    sha1sum liferay-ce-portal-wildfly-$LIFERAY_VERSION_FULL.zip | grep $LIFERAY_SHA1 && \
    unzip liferay-ce-portal-wildfly-$LIFERAY_VERSION_FULL.zip > /dev/null && \
    mv liferay-ce-portal-7.0-ga3/* . && \
    rm -rf liferay-ce-portal-7.0-ga3

EXPOSE 8080 9990

CMD ["/opt/jboss/wildfly-10.0.0/bin/standalone.sh", "-b", "0.0.0.0"]
