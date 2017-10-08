FROM ubuntu:16.04
MAINTAINER lx,simolx@163.com
ENV TZ Asia/Shanghai
# RUN /bin/cp -f /usr/share/zoneinfo/$TZ /etc/localtime
RUN apt update && \
    apt upgrade -y && \
    apt install -y curl unzip bzip2 && \
    rm -rf /var/lib/apt/lists/*
RUN curl -O -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.tar.gz && \
    tar -xzf jdk-8u144-linux-x64.tar.gz -C /opt && \
    rm -f jdk-8u144-linux-x64.tar.gz && \
    curl -O https://repo.continuum.io/archive/Anaconda3-5.0.0.1-Linux-x86_64.sh && \
    bash Anaconda3-5.0.0.1-Linux-x86_64.sh -b -f -p /opt/anaconda3 && \
    rm -f Anaconda3-5.0.0.1-Linux-x86_64.sh && \
    curl -O http://www-us.apache.org/dist/zeppelin/zeppelin-0.7.3/zeppelin-0.7.3-bin-all.tgz && \
    tar -xzf zeppelin-0.7.3-bin-all.tgz -C /opt && \
    rm -f zeppelin-0.7.3-bin-all.tgz && \
    cp /opt/zeppelin-0.7.3-bin-all/conf/zeppelin-env.sh.template /opt/zeppelin-0.7.3-bin-all/conf/zeppelin-env.sh && \
    cp /opt/zeppelin-0.7.3-bin-all/conf/zeppelin-site.xml.template /opt/zeppelin-0.7.3-bin-all/conf/zeppelin-site.xml
ENV JAVA_HOME=/opt/jdk1.8.0_144 \
    PATH=/opt/anaconda3/bin:$JAVA_HOME/bin:$PATH \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8
RUN conda update -y conda && \
    conda update -y anaconda && \
    conda update -y --all && \
    python -m nltk.downloader all
VOLUME ["/opt/zeppelin-0.7.3-bin-all/notebook"]
EXPOSE 8080
CMD ["/opt/zeppelin-0.7.3-bin-all/bin/zeppelin.sh"]
