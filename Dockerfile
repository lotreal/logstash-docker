FROM java:8-jre

MAINTAINER Luo Tao <lotreal@gmail.com>

# Download version 1.4.2 of logstash
RUN cd /tmp && \
    wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz && \
    tar -xzf ./logstash-1.4.2.tar.gz && \
    mv ./logstash-1.4.2 /opt/logstash && \
    rm ./logstash-1.4.2.tar.gz

# Install contrib plugins
RUN /opt/logstash/bin/plugin install contrib

ENTRYPOINT ["/opt/logstash/bin/logstash", "-f", "/etc/logstash.conf"]
