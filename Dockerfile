FROM yimik/java-zh-font:8-jdk-jammy
MAINTAINER yimik "398075986@163.com"

RUN export DEBIAN_FRONTEND=noninteractive && \
    sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list &&  \
    apt update && apt install -y wget libnss3 libcairo2 libxslt1.1 libcups2 libx11-xcb1 && \
    wget https://download.documentfoundation.org/libreoffice/stable/24.2.4/deb/x86_64/LibreOffice_24.2.4_Linux_x86-64_deb.tar.gz && \
    tar -xzf LibreOffice_24.2.4_Linux_x86-64_deb.tar.gz && \
    dpkg -i LibreOffice_24.2.4*/DEBS/*.deb && \
    rm -rf LibreOffice_24.2.4* && \
    wget https://download.documentfoundation.org/libreoffice/stable/24.2.4/deb/x86_64/LibreOffice_24.2.4_Linux_x86-64_deb_langpack_zh-CN.tar.gz &&  \
    tar -xzf LibreOffice_24.2.4_Linux_x86-64_deb_langpack_zh-CN.tar.gz  && \
    dpkg -i LibreOffice_24.2.4*/DEBS/*.deb && \
    rm -rf LibreOffice_24.2.4* && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ADD server/target/kkFileView-*.tar.gz /opt/
ENV KKFILEVIEW_BIN_FOLDER /opt/kkFileView-4.4.0-beta/bin
ENTRYPOINT ["java","-Dfile.encoding=UTF-8","-Dspring.config.location=/opt/kkFileView-4.4.0-beta/config/application.properties","-jar","/opt/kkFileView-4.4.0-beta/bin/kkFileView-4.4.0-beta.jar"]