FROM ubuntu:14.04
MAINTAINER nabezokodaikon

ENV DEBIAN_FRONTEND noninteractive

# リポジトリを日本語向けに変更します。
RUN sed -e 's;http://archive;http://jp.archive;' -e 's;http://us\.archive;http://jp.archive;' -i /etc/apt/sources.list
RUN [ ! -x /usr/bin/wget ] && apt-get update && \
    apt-get install -y wget && \
    touch /.get-wget
RUN wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- | apt-key add - && \
    wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- | apt-key add - && \
    wget https://www.ubuntulinux.jp/sources.list.d/trusty.list -O /etc/apt/sources.list.d/ubuntu-ja.list

# システムを更新します。
RUN apt-get update && \
    apt-get dist-upgrade -y
RUN apt-get upgrade

# 日本語パッケージをインストールします。
RUN apt-get install -y language-pack-ja

# タイムゾーンを日本標準時刻に設定します。
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN echo 'Asia/Tokyo' > /etc/timezone

# ハードウェアクロックをローカルタイムに設定します。
RUN sed -e 's;UTC=yes;UTC=no;' -i /etc/default/rcS

# ロケールを日本語に設定します。
RUN echo 'LC_ALL=ja_JP.UTF-8' > /etc/default/locale
RUN echo 'LANG=ja_JP.UTF-8' >> /etc/default/locale
RUN echo locale-gen ja_JP.UTF-8

# デフォルトロケールを日本語向けに設定します。
ENV LC_ALL ja_JP.UTF-8
ENV LANG j_JP.UTF-8

# java をインストールします。
RUN apt-get install -q -y openjdk-7-jre-headless
RUN apt-get clean

RUN wget https://github.com/takezoe/gitbucket/releases/download/2.4.1/gitbucket.war -P /opt

VOLUME /root/.gitbucket
EXPOSE 8080

CMD ["java", "-jar", "/opt/gitbucket.war"]

