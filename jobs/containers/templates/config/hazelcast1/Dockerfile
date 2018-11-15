FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install zip -y
RUN apt-get install unzip -y

RUN apt-get install -y software-properties-common

# Installing Java.
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# set PATH so it includes user's private bin directories
#PATH="$HOME/bin:$HOME/.local/bin:$PATH"
ENV PATH=$PATH:/home/apcuser/apps/jdk1.8.0_144/bin:
ENV JAVA_HOME=/home/apcuser/apps/jdk1.8.0_144
ENV TMP_HOME=/tmp
ENV CACHE_HOME=/home/apcuser/apps/alcatraz_cache
ENV BUILD_HOME=/data/builds

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV CACHE_HOME /home/apcuser/apps/alcatraz_cache


#installing Hazelcast

# Versions of Hazelcast and Hazelcast plugins
ARG HZ_VERSION=3.7.4
ARG CACHE_API_VERSION=1.0.0
ARG HZ_KUBE_VERSION=1.3.1
ARG HZ_EUREKA_VERSION=1.0.2

# Build constants
ARG HZ_HOME="/opt/hazelcast"
ARG HZ_JAR="hazelcast-all-${HZ_VERSION}.jar"
ARG CACHE_API_JAR="cache-api-${CACHE_API_VERSION}.jar"

# Set up build directory
RUN mkdir -p ${HZ_HOME}
WORKDIR ${HZ_HOME}

# Download & install Hazelcast
RUN wget  https://repo1.maven.org/maven2/com/hazelcast/hazelcast/${HZ_VERSION}/hazelcast-${HZ_VERSION}.jar
RUN wget https://repo1.maven.org/maven2/com/hazelcast/hazelcast-client/${HZ_VERSION}/hazelcast-client-${HZ_VERSION}.jar
RUN wget https://github.com/takari/maven-wrapper/archive/maven-wrapper-0.3.0.tar.gz
RUN tar zxf maven-wrapper-0.3.0.tar.gz
RUN rm -rf maven-wrapper-0.3.0.tar.gz
RUN mv maven-wrapper* mvnw


# Runtime constants
ENV CLASSPATH_DEFAULT "${HZ_HOME}:${HZ_HOME}/*"
ENV JAVA_OPTS_DEFAULT "-Djava.net.preferIPv4Stack=true"

# Runtime environment variables
ENV MIN_HEAP_SIZE ""
ENV MAX_HEAP_SIZE ""
ENV CLASSPATH ""
ENV JAVA_OPTS ""


#Copying custom alcatraz jars 

RUN mkdir -p /home/apcuser/apps/alcatraz_cache
RUN cp hazelcast-${HZ_VERSION}.jar  /home/apcuser/
RUN cp hazelcast-client-${HZ_VERSION}.jar /home/apcuser/

### Expose port
EXPOSE 5701

CMD mkdir -p /data/builds
CMD mkdir -p /home/apcuser/apps/alcatraz_cache
COPY alcatraz_cache*.zip /data/builds/
COPY sdet_conf.tar /data/builds/
COPY currentbuild.sh /data/builds/
COPY start_hazelcast.sh /home/apcuser/
COPY zookeeper.cfg /home/apcuser/apps/alcatraz_cache/
COPY product-build.info /home/apcuser/apps/alcatraz_cache/
CMD . /home/apcuser/start_hazelcast.sh

