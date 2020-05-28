FROM alpine:3.7
MAINTAINER Peter Willemsen <peter@codebuffet.co>
RUN apk add --no-cache openssh
RUN /usr/bin/ssh-keygen -A
RUN mkdir -p /root/.ssh
# This is used to unlock the root account...
RUN echo 'root:ROOT_PW' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
RUN sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
EXPOSE 22
CMD ["/usr/sbin/sshd", "-d", "-D"]
