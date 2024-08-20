# ベースイメージとしてUbuntuを使用
FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y openjdk-17-jre-headless && \
    apt-get clean

# 作業ディレクトリを設定
WORKDIR /minecraft

# 必要なパッケージのインストール
RUN apt-get update && \
    apt-get install -y openjdk-17-jre-headless wget && \
    apt-get clean

# BungeeCordの設定
COPY ./bungee /minecraft/bungee
WORKDIR /minecraft/bungee
RUN chmod +x ./bungee.jar

# Minecraftサーバーの設定
COPY ./server /minecraft/server
WORKDIR /minecraft/server
RUN chmod +x ./server.jar

# ポートの公開
EXPOSE 25565 25577

# サーバーの実行
CMD java -jar /minecraft/bungee/bungee.jar
