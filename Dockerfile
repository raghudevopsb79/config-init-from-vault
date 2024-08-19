FROM          redhat/ubi9
COPY          run.sh /
ENTRYPOINT    ["bash", "/run.sh"]
RUN           yum install -y yum-utils ; yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo ;yum -y install vault


