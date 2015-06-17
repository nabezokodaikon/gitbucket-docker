FROM ubuntu:14.04
MAINTAINER nabezokodaikon

ENV DEBIAN_FRONTEND noninteractive

# システムを更新します。
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y && \
    apt-get autoremove --purge -y && \
    apt-get autoclean -y

# タイムゾーンを日本標準時刻に設定します。
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN echo 'Asia/Tokyo' > /etc/timezone

# ハードウェアクロックをローカルタイムに設定します。
RUN sed -e 's;UTC=yes;UTC=no;' -i /etc/default/rcS

# パッケージインストールします。
RUN apt-get install -q -y \
    wget \
    openjdk-7-jre-headless
RUN apt-get clean

RUN wget https://github.com/takezoe/gitbucket/releases/download/3.3/gitbucket.war -P /opt
RUN mkdir /root/.gitbucket
ADD ./gitbucket.conf /root/.gitbucket/gitbucket.conf

VOLUME /root/.gitbucket
EXPOSE 8080

CMD ["java", "-jar", "/opt/gitbucket.war", "--port", "8080"]

