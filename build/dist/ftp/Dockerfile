FROM alpine
RUN apk --no-cache add vsftpd

ARG UID=1000
ARG FTP_USER=dev
ARG FTP_PASSWORD=dev

RUN echo -e "$FTP_PASSWORD\n$FTP_PASSWORD" \
    | adduser -h /data -s /sbin/nologin -u "$UID" "$FTP_USER" \
    && mkdir -p /data \
    && chown "$FTP_USER:$FTP_USER" /data

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf

EXPOSE 21
VOLUME /data

ENTRYPOINT ["/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]
