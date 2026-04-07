FROM nginx:latest

EXPOSE 8080
WORKDIR /app

# 复制配置
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /app/entrypoint.sh

RUN apt-get update && apt-get install -y wget unzip && \
    wget -O v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip && \
    unzip v2ray.zip && \
    mv v2ray v && \
    chmod +x v /app/entrypoint.sh && \
    rm -f v2ray.zip

ENTRYPOINT ["/app/entrypoint.sh"]
