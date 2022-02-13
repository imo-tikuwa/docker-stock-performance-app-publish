FROM mysql:5.7

# https://qiita.com/koyo-miyamura/items/4d1430b9086c5d4a58a5
ADD ./conf.d/my.cnf /etc/mysql/conf.d/my.cnf
RUN chmod 644 /etc/mysql/conf.d/my.cnf

RUN { \
        echo "alias ll='ls -l --color=auto'"; \
    } >> /root/.bashrc

RUN touch /var/log/mysql/mysqld.log