FROM centos

MAINTAINER nmochizuki

ENV IP 192.168.59.103
ENV PW test
ENV LOGSERVER localhost

# 
RUN yum -y update
RUN yum install -y sudo openssh openssh-server openssh-clients passwd wget curl
RUN yum install -y vim git

# user settings
RUN useradd nmochizuki
RUN passwd -f -u nmochizuki
RUN mkdir -p /home/nmochizuki/.ssh; chown nmochizuki /home/nmochizuki/.ssh; chmod 700 /home/nmochizuki/.ssh
ADD sshd/authorized_keys /home/nmochizuki/.ssh/authorized_keys
RUN chown nmochizuki /home/nmochizuki/.ssh/authorized_keys; chmod 600 /home/nmochizuki/.ssh/authorized_keys;
RUN echo "nmochizuki ALL=(ALL) ALL" >> /etc/sudoers.d/nmochizuki
ADD sshd/sshd_config /etc/ssh/sshd_config
ADD sshd/ssh_host_dsa_key /etc/ssh/ssh_host_dsa_key
ADD sshd/ssh_host_rsa_key /etc/ssh/ssh_host_rsa_key
RUN chmod 600 /etc/ssh/ssh_host_dsa_key
RUN chmod 600 /etc/ssh/ssh_host_rsa_key

# app settings
#RUN yum install -y fluentd

RUN useradd www-data
ADD nginx/nginx.repo /etc/yum.repos.d/nginx.repo
RUN chmod 0644 /etc/yum.repos.d/nginx.repo
RUN yum install -y nginx
ADD nginx/nginx.conf /etc/nginx/nginx.conf
ADD nginx/default.conf /etc/nginx/conf.d/default.conf
ADD nginx/hello.html /usr/share/nginx/html/hello.html

# supervisord
RUN wget http://peak.telecommunity.com/dist/ez_setup.py;python ez_setup.py;easy_install distribute;
RUN wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py;python get-pip.py;
RUN pip install supervisor
ADD supervisord/supervisord.conf /etc/supervisord.conf

# 
EXPOSE 2222 80
CMD ["/usr/bin/supervisord"]
