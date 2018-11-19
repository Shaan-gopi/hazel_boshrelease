FROM hazelcast/hazelcast:3.7.4
# Adding custom hazelcast.xml
ADD alcatraz_cache_*.zip ${HZ_HOME}
WORKDIR ${HZ_HOME}
RUN unzip alcatraz_cache_*.zip
COPY server.sh ${HZ_HOME}
COPY zookeeper.cfg ${HZ_HOME}/conf
#RUN cp ${HZ_HOME}/*hazelcast-all*.jar /opt/hazelcast/lib/
ENV JAVA_OPTS -Dhazelcast.config=${HZ_HOME}/hazelcast.xml
ENV CACHE_HOME=${HZ_HOME}
