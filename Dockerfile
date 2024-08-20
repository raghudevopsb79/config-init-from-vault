FROM          redhat/ubi9
RUN           yum install unzip -y
RUN           curl -L -O https://releases.hashicorp.com/vault/1.17.3/vault_1.17.3_linux_amd64.zip && unzip vault_1.17.3_linux_amd64.zip && mv vault /bin
RUN           curl -L -o /bin/kubectl https://dl.k8s.io/release/v1.31.0/bin/linux/amd64/kubectl && chmod +x /bin/kubectl
COPY          run.sh /
ENTRYPOINT    ["bash", "/run.sh"]



