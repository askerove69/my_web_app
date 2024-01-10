# Используйте легковесный базовый образ
FROM alpine:latest

# Обновление и установка NGINX
RUN apk update && apk add nginx

# Очистка директории /var/www/
RUN rm -rf /var/www/*

# Замена конфигурации NGINX
COPY nginx.conf /etc/nginx/nginx.conf

# Создание директории /var/www/my_project
RUN mkdir -p /var/www/my_project

# Копирование файлов index.html
COPY index.html /var/www/my_project/

# Установка прав
RUN addgroup -g 1001 mygroup && adduser -D -u 1001 -G mygroup myuser
RUN chown -R myuser:mygroup /var/www/my_project /var/lib/nginx

# Запуск NGINX
CMD ["nginx", "-g", "daemon off;"]
