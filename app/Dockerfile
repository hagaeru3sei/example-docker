FROM centos

MAINTAINER Nobuaki Mochizuki

ENV IP 192.168.59.104
ENV PYTHONPATH .:/usr/lib/python3.4:/usr/lib/python3.4/site-packages:/usr/lib64/python3.4:/usr/lib64/python3.4/site-packages

WORKDIR /tmp

# Install libs
RUN yum localinstall -y --nogpgcheck http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN yum -y update
RUN yum install -y gcc bzip2 bzip2-devel openssl openssl-devel readline readline-devel wget curl mysql mysql-devel git unzip
RUN yum install -y --enablerepo=epel python34 python34-devel python34-tools python34-libs

# app settings
RUN wget https://pypi.python.org/packages/source/d/distribute/distribute-0.7.3.zip; \
  unzip distribute-0.7.3.zip; \
  cd distribute-0.7.3; \
  python3.4 setup.py install; \
  easy_install pip
#RUN python3.4 -m pip install mysqlclient
RUN pip install PyMySQL
RUN pip install tornado
RUN pip install gunicorn
RUN mkdir -p /opt/app/logs
ADD build/gunicorn.conf.py /opt/app/conf/gunicorn.conf.py
ADD build/main.py /opt/app/main.py
ADD build/app.sh /opt/app/app.sh

# 
EXPOSE 8000
ENTRYPOINT ["/opt/app/app.sh"]
CMD ["start"]
