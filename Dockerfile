FROM yimik/java-zh-font:8-jdk-jammy
MAINTAINER yimik "398075986@163.com"

RUN export DEBIAN_FRONTEND=noninteractive && \
    sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list &&  \
    apt update && apt install -y software-properties-common gnupg2 && \
    add-apt-repository -y ppa:libreoffice/ppa && \
    apt update && \
    apt install -y libreoffice=4:24.2.5~rc2-0ubuntu0.22.04.1~lo1 libreoffice-l10n-zh-cn && \
    apt-get clean

# 删除不必要的文件以减小镜像大小
RUN apt-get remove --purge -y \
    software-properties-common && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV KK_OFFICE_HOME /usr/lib/libreoffice

ADD server/target/kkFileView-*.tar.gz /opt/
ENV KKFILEVIEW_BIN_FOLDER /opt/kkFileView-4.4.0-beta/bin
ENTRYPOINT ["java","-Dfile.encoding=UTF-8","-Dspring.config.location=/opt/kkFileView-4.4.0-beta/config/application.properties","-jar","/opt/kkFileView-4.4.0-beta/bin/kkFileView-4.4.0-beta.jar"]