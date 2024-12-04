FROM dockerpull.org/node:20.11.1-alpine3.19
#USER node

WORKDIR /opt/mcsmanager
RUN wget https://mcsmanager.oss-cn-guangzhou.aliyuncs.com/mcsmanager_linux_release.tar.gz
RUN tar -zxf mcsmanager_linux_release.tar.gz 
#RUN ls
#install
WORKDIR /opt/mcsmanager/daemon
RUN npm install --production --no-fund --no-audit
WORKDIR /opt/mcsmanager/web
RUN npm install --production --no-fund --no-audit
#create startup.sh
WORKDIR /opt/mcsmanager
RUN echo -e '#!/bin/bash\n' > startup.sh && \ 
    echo 'sh start-daemon.sh &' >> startup.sh && \
    echo 'sh start-web.sh' >> startup.sh
#RUN ["echo", "-e", "sh start-daemon.sh &\n sh start-web.sh &", ">", "/opt/mcsmanager/startup.sh"]
COPY global.json /opt/mcsmanager/daemon/data/Config/
COPY hajimi /opt/mcsmanager/
RUN chmod +x /opt/mcsmanager/startup.sh
RUN chmod -R 777 /opt/mcsmanager
#VOLUME ["/opt/mcsmanager/daemon/data", "/opt/mcsmanager/daemon/logs"]
#VOLUME ["/opt/mcsmanager/web/data", "/opt/mcsmanager/web/logs"]
#RUN pwd
#RUN ls
#CMD ["/bin/bash"]
#ENTRYPOINT ["/opt/mcsmanager/startup.sh"]
CMD ["sh", "/opt/mcsmanager/startup.sh"]
EXPOSE 23333
EXPOSE 48994