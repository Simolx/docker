FROM centos:7
MAINTAINER lx,simolx@163.com
ENV TZ Asia/Shanghai
ENV LC_ALL en_US.UTF-8
ENV SPARK_VERSION=2.0.1
RUN /bin/cp -f /usr/share/zoneinfo/$TZ /etc/localtime
RUN yum -y update && yum install -y which openssh openssh-clients openssh-server bzip2 mariadb mariadb-devel gcc gcc-c++ cyrus-sasl-devel cyrus-sasl-plain cyrus-sasl-gssapi cyrus-sasl-scram cyrus-sasl-md5 libffi-devel libxml2-devel libxslt-devel vim sudo postgresql-devel crontabs
RUN localedef -i en_US -f UTF-8 en_US.UTF-8
ENV TINI_VERSION v0.13.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ADD https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh /opt
RUN mkdir -p /opt/sparkdistribute/classpath
ADD jdk-8u112-linux-x64.tar.gz /opt/sparkdistribute
ADD spark-${SPARK_VERSION}-bin-hadoop2.4.tgz /opt/sparkdistribute
ADD hadoop-2.5.2.tar.gz /opt/sparkdistribute
# RUN tar -xzf /opt/sparkdistribute/jdk-8u112-linux-x64.tar.gz -C /opt/sparkdistribute \
#     && tar -xzf /opt/sparkdistribute/spark-${SPARK_VERSION}-bin-hadoop2.4.tgz -C /opt/sparkdistribute \
#     && tar -xzvf /opt/sparkdistribute/hadoop-2.5.2.tar.gz -C /opt/sparkdistribute
#     && rm -f /opt/sparkdistribute/jdk-8u112-linux-x64.tar.gz /opt/sparkdistribute/spark-${SPARK_VERSION}-bin-hadoop2.4.tgz /opt/sparkdistribute/hadoop-2.5.2.tar.gz
ADD conf /opt/sparkdistribute/spark-${PARK_VERSION}-bin-hadoop2.4
ADD hadoop /opt/sparkdistribute
# ADD *.jar /opt/sparkdistribute/classpath
ADD hbase-1.0.0.tar.gz /opt
RUN bash /opt/Miniconda2-latest-Linux-x86_64.sh -b -p /opt/miniconda2 && rm -f /opt/Miniconda2-latest-Linux-x86_64.sh
ENV JAVA_HOME /opt/sparkdistribute/jdk1.8.0_112
ENV PATH $JAVA_HOME/bin:/opt/miniconda2/bin:$PATH
ENV AIRFLOW_HOME /opt/airflow
VOLUME [ "/etc/supervisord", "$AIRFLOW_HOME/dags", "/opt/baitu" ]
RUN mkdir -p /var/log/airflow /etc/supervisord /opt/baitu
RUN pip install --upgrade pip && pip install airflow[all_dbs,async,celery,crypto,datadog,devel_hadoop,docker,druid,emr,gcp_api,github_enterprise,jdbc,ldap,qds,rabbitmq,salesforce,samba,slack,statsd,vertica] supervisor suds pyhs2 kafka-python pyhive[hive,sqlalchemy] thrift
RUN tar -czvf /opt/hbase-1.0.0.tar.gz -C  /opt hbase-1.0.0 && pip install /opt/hbase-1.0.0.tar.gz && rm -f /opt/hbase-1.0.0.tar.gz
ADD supervisord.conf /etc/
ADD airflow.cfg $AIRFLOW_HOME
RUN sed -i -e '/Defaults    requiretty/{ s/.*/# Defaults    requiretty/ }' /etc/sudoers
RUN useradd dataflow && useradd isearch
WORKDIR /opt/baitu
ENV HADOOP_HOME /opt/sparkdistribute/hadoop-2.5.2
ENV HADOOP_PREFIX $HADOOP_HOME
ENV HADOOP_MAPRED_HOME $HADOOP_HOME
ENV HADOOP_COMMON_HOME $HADOOP_HOME
ENV HADOOP_HDFS_HOME $HADOOP_HOME
ENV YARN_HOME $HADOOP_HOME
ENV HADOOP_CONF_DIR $HADOOP_HOME/etc/hadoop
ENV HDFS_CONF_DIR $HADOOP_HOME/etc/hadoop
ENV YARN_CONF_DIR $HADOOP_HOME/etc/hadoop

EXPOSE 8081 9001 19090
ENTRYPOINT ["/tini", "--"]
CMD ["/bin/bash", "-c", "supervisord -n -c /etc/supervisord.conf"]
