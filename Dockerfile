ARG FROM=ubuntu:22.04
FROM ${FROM}
#FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive
ARG TERRAFORM_VERSION="1.2.6"
ARG TFLINT_VERSION="0.39.1"
ARG TERRAFORMDOCS_VERSION="0.16.0"

# Labels.
LABEL maintainer="ravi.singh" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.description="Dockerized Terraform OSS , TFLINT and CHECKOV                                                                                            " \
    org.label-schema.vendor="TTC" \
    org.label-schema.docker.cmd="docker run -it --entrypoint /bin/bash tools-tf:                                                                                           v1.0.0"

#  Link Bash to SH

RUN ln -sf /bin/bash /bin/sh

# Update Base Image With Required Packages

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y \
        curl \
        unzip \
        apt-transport-https \
        ca-certificates \
        software-properties-common \
        sudo \
        jq \
        wget \
        git \
        iputils-ping \
        build-essential \
        python3-pip \
        zlib1g-dev \
        gettext && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# Download and Install Terraform
WORKDIR /tmp

RUN curl -O -L https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/ter                                                                                           raform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && mv terraform /usr/local/bin \
    && chmod a+x /usr/local/bin/terraform

# Download and Install TFLINT

RUN curl --retry 5 --retry-max-time 60 -O -L https://github.com/terraform-linter                                                                                           s/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip \
    && unzip tflint_linux_amd64.zip \
    && rm tflint_linux_amd64.zip \
    && mv tflint /usr/local/bin \
    && chmod a+x /usr/local/bin/tflint

# Install Checkov

RUN pip3 install -U checkov

# Download and Install Terraform Docs

RUN curl -O -L https://github.com/terraform-docs/terraform-docs/releases/downloa                                                                                           d/v${TERRAFORMDOCS_VERSION}/terraform-docs-v${TERRAFORMDOCS_VERSION}-linux-amd64                                                                                           .tar.gz \
    && tar -zxf terraform-docs-v${TERRAFORMDOCS_VERSION}-linux-amd64.tar.gz \
    && rm terraform-docs-v${TERRAFORMDOCS_VERSION}-linux-amd64.tar.gz \
    && mv terraform-docs /usr/local/bin \
    && chmod a+x /usr/local/bin/terraform-docs \
    && rm README.md LICENSE



# Switch Workdir to /

WORKDIR /

# Entry Point
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
