FROM nginx:latest

WORKDIR /app
USER root

EXPOSE 8080

COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh ./

RUN apt-get update && apt-get install -y wget unzip && \
    wget -O temp.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip && \
    unzip temp.zip v2ray geoip.dat geosite.dat && \
    mv v2ray v && \
    rm -f temp.zip && \
    chmod +x v entrypoint.sh

# ✅ 用 cat 写配置（不会报错）
RUN cat > /app/config.json << 'EOF'
{
  "log": { "loglevel": "warning" },
  "inbounds": [
    {
      "port": 10000,
      "protocol": "vmess",
      "listen": "127.0.0.1",
      "settings": {
        "clients": [
          {
            "id": "7a5b9b7d-5f29-4a72-ac79-d19a22fba644",
            "alterId": 0
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": { "path": "/vmess" }
      }
    },
    {
      "port": 20000,
      "protocol": "vless",
      "listen": "127.0.0.1",
      "settings": {
        "clients": [
          {
            "id": "7a5b9b7d-5f29-4a72-ac79-d19a22fba644"
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": { "path": "/vless" }
      }
    }
  ],
  "outbounds": [
    { "protocol": "freedom" }
  ]
}
EOF

ENTRYPOINT ["./entrypoint.sh"]
