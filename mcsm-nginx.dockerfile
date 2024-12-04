# 基于官方的 NGINX 镜像
FROM nginx:latest

# 复制自定义的 NGINX 配置文件到容器中
COPY nginx.conf /etc/nginx/nginx.conf

# 复制 SSL 证书和私钥到容器中
COPY certs/server.crt /etc/nginx/certs/server.crt
COPY certs/server.key /etc/nginx/certs/server.key

# 暴露端口 443 (HTTPS)
EXPOSE 443

# 启动 NGINX
CMD ["nginx", "-g", "daemon off;"]
