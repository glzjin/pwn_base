FROM ubuntu:16.04

COPY ./ctf.xinetd /etc/xinetd.d/ctf

RUN sed -i "s/http:\/\/archive.ubuntu.com/http:\/\/mirrors.aliyun.com/g" /etc/apt/sources.list && \
    apt-get update && apt-get -y dist-upgrade && \
    apt-get install -y lib32z1 xinetd build-essential && \
    useradd -m ctf && \
    echo 'ctf - nproc 1500' >>/etc/security/limits.conf

CMD exec /bin/bash -c "chown root:ctf /pwn/pwn && chmod 750 /pwn/pwn && echo $FLAG > /flag && export FLAG=not_flag && FLAG=not_flag && /etc/init.d/xinetd start; trap : TERM INT; sleep infinity & wait"

EXPOSE 10000
