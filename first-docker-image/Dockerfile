FROM alpine
ENV MESSAGE MESSAGE
RUN echo 'Hell from from docker container\n' >> /message
RUN printenv >> /message

CMD ["cat", "/message"]
