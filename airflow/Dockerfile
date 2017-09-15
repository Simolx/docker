FROM centos:7
MAINTAINER lx,simolx@163.com
ENV TZ Asia/Shanghai
ENV SPARK_VERSION 2.1.1
ENV AIRFLOW_VERSION 1.8.2
RUN /bin/cp -f /usr/share/zoneinfo/$TZ /etc/localtime
RUN yum update -y && \
    yum install -y which openssh openssh-clients openssh-server bzip2 mariadb mariadb-devel gcc gcc-c++ cyrus-sasl-devel cyrus-sasl-plain cyrus-sasl-gssapi cyrus-sasl-scram cyrus-sasl-md5 libffi-devel libxml2-devel libxslt-devel vim sudo postgresql-devel crontabs && \
    yum clean all
RUN localedef -i en_US -f UTF-8 en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest| grep -o "/v.*\""| sed 's:^..\(.*\).$:\1:'` && \
    curl -L https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini > /tini && \
    chmod +x /tini
RUN curl -L https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh > /opt/Miniconda2-latest-Linux-x86_64.sh
RUN mkdir -p /opt/sparkdistribute/classpath
COPY jdk-8u144-linux-x64.tar.gz /opt/sparkdistribute/
RUN curl -L https://www.apache.org/dyn/closer.lua/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.4.tgz > /opt/spark-${SPARK_VERSION}-bin-hadoop2.4.tgz && \
    tar -xzvf /opt/spark-${SPARK_VERSION}-bin-hadoop2.4.tgz -C /opt/sparkdistribute && \
    rm -f /opt/spark-${SPARK_VERSION}-bin-hadoop2.4.tgz
# RUN tar -xzf /opt/sparkdistribute/jdk-8u112-linux-x64.tar.gz -C /opt/sparkdistribute \
#     && tar -xzf /opt/sparkdistribute/spark-${SPARK_VERSION}-bin-hadoop2.4.tgz -C /opt/sparkdistribute \
#     && tar -xzvf /opt/sparkdistribute/hadoop-2.5.2.tar.gz -C /opt/sparkdistribute
#     && rm -f /opt/sparkdistribute/jdk-8u112-linux-x64.tar.gz /opt/sparkdistribute/spark-${SPARK_VERSION}-bin-hadoop2.4.tgz /opt/sparkdistribute/hadoop-2.5.2.tar.gz
COPY conf /opt/sparkdistribute/spark-${PARK_VERSION}-bin-hadoop2.4/
COPY hadoop /opt/sparkdistribute/
# ADD *.jar /opt/sparkdistribute/classpath
COPY hbase-1.0.0.tar.gz /opt/
RUN bash /opt/Miniconda2-latest-Linux-x86_64.sh -b -p /opt/miniconda2 && rm -f /opt/Miniconda2-latest-Linux-x86_64.sh
ENV JAVA_HOME /opt/sparkdistribute/jdk1.8.0_112
ENV PATH $JAVA_HOME/bin:/opt/miniconda2/bin:$PATH
ENV AIRFLOW_HOME /opt/airflow
RUN mkdir -p /var/log/airflow /etc/supervisord /opt/baitu
RUN curl -L https://github.com/apache/incubator-airflow/archive/${AIRFLOW_VERSION}.tar.gz > /opt/airflow-${AIRFLOW_VERSION}.tar.gz && \
    pip install --upgrade pip  && \
    pip install --upgrade supervisor suds kafka-python pyhive[hive,sqlalchemy,presto] thrift && \
    pip install /opt/airflow-${AIRFLOW_VERSION}.tar.gz[all_dbs,async,celery,crypto,datadog,devel_hadoop,docker,druid,emr,gcp_api,jdbc,ldap,qds,rabbitmq,salesforce,samba,statsd] && \
    rm -f /opt/airflow-${AIRFLOW_VERSION}.tar.gz
RUN tar -czvf /opt/hbase-1.0.0.tar.gz -C  /opt hbase-1.0.0 && \
    pip install /opt/hbase-1.0.0.tar.gz && \
    rm -f /opt/hbase-1.0.0.tar.gz
RUN rm -rf ~/.cache/pip/* 
COPY supervisord.conf /etc/
COPY airflow.cfg $AIRFLOW_HOME/
RUN sed -i -e '/Defaults    requiretty/{ s/.*/# Defaults    requiretty/ }' /etc/sudoers
RUN useradd dataflow && useradd isearch
ENV HADOOP_HOME /opt/sparkdistribute/hadoop-2.5.2
# ENV HADOOP_PREFIX $HADOOP_HOME
# ENV HADOOP_MAPRED_HOME $HADOOP_HOME
# ENV HADOOP_COMMON_HOME $HADOOP_HOME
# ENV HADOOP_HDFS_HOME $HADOOP_HOME
# ENV YARN_HOME $HADOOP_HOME
# ENV HADOOP_CONF_DIR $HADOOP_HOME/etc/hadoop
# ENV HDFS_CONF_DIR $HADOOP_HOME/etc/hadoop
# ENV YARN_CONF_DIR $HADOOP_HOME/etc/hadoop

WORKDIR /opt/baitu
VOLUME [ "/etc/supervisord", "$AIRFLOW_HOME/dags", "/opt/baitu" ]
EXPOSE 8081 9001 19090
ENTRYPOINT ["/tini", "--"]
CMD ["/bin/bash", "-c", "supervisord -n -c /etc/supervisord.conf"]
