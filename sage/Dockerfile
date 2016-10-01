FROM centos
MAINTAINER Dieudonne, lx.simon@yahoo.com

ENV SAGE_VERSION 7.3
ENV YASM_VERSION 1.3.0
ENV FFMPEG_VERSION 3.1.3
ENV SAGE_ROOT /home/sage/software/sage-$SAGE_VERSION
VOLUME [/home/sage/notebook_data.sagenb]
RUN yum install -y deltarpm
RUN yum update -y
RUN yum install -y binutils gcc gcc-c++ gcc-gfortran make m4 perl tar git perl-ExtUtils-MakeMaker dvipng ImageMagick openssh-server openssh-client openssl openssl-devel tk tk-devel which perl-Digest-MD5 texlive bzip2 xmlto
RUN mkdir /opt/software
ADD http://www.tortall.net/projects/yasm/releases/yasm-$YASM_VERSION.tar.gz /opt/software
RUN tar -xzf /opt/software/yasm-$YASM_VERSION.tar.gz -C /opt/software
WORKDIR /opt/software/yasm-$YASM_VERSION
RUN ./configure && make && make install
ADD http://ffmpeg.org/releases/ffmpeg-$FFMPEG_VERSION.tar.bz2 /opt/software
RUN tar -xjf /opt/software/ffmpeg-$FFMPEG_VERSION.tar.bz2 -C /opt/software
WORKDIR /opt/software/ffmpeg-$FFMPEG_VERSION
RUN ./configure && make && make install
RUN rm -f /opt/software/yasm-$YASM_VERSION.tar.gz /opt/software/ffmpeg-$FFMPEG_VERSION.tar.bz2
RUN useradd sage
RUN mkdir -p /home/sage/software
ADD https://mirrors.tuna.tsinghua.edu.cn/sagemath/src/sage-$SAGE_VERSION.tar.gz /home/sage/software
RUN chown -R sage:sage /home/sage
USER sage
RUN tar -xzf /home/sage/software/sage-$SAGE_VERSION.tar.gz -C /home/sage/software
RUN rm -f /home/sage/software/sage-$SAGE_VERSION.tar.gz
WORKDIR $SAGE_ROOT
RUN make
EXPOSE 8080
EXPOSE 22
CMD $SAGE_ROOT/sage
#CMD $SAGE_ROOT/sage -notebook interface=\'\' port=8080 open_viewer=False automatic_login=False
#CMD /bin/bash
