FROM mysql:8.0

ADD ./conf.d/my.cnf /etc/mysql/conf.d/my.cnf
RUN chmod 644 /etc/mysql/conf.d/my.cnf

RUN { \
        echo "alias ll='ls -l --color=auto'"; \
    } >> /root/.bashrc