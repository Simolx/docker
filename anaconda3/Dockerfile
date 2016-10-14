FROM continuumio/anaconda3
MAINTAINER Dieudonne, lx.simon@yahoo.com

VOLUME [/opt/notebooks]
RUN mkdir /opt/notebooks
RUN /opt/conda/bin/conda install jupyter -y --quiet
EXPOSE 8888
CMD [ "/bin/bash", "-c", "/opt/conda/bin/jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --port=8888 --no-browser" ]
