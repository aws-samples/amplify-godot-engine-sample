FROM amazonlinux:latest

ARG BASE_URL="https://downloads.tuxfamily.org/godotengine"
ARG GODOT_VERSION="4.2.2"
ARG RELEASE_NAME="stable"
ARG SUBDIR=""
ARG GODOT_TEST_ARGS=""
ARG GODOT_PLATFORM="linux.x86_64"

RUN yum update -y \
    && yum install -y wget unzip git openssh nodejs tar jq awscli

RUN wget ${BASE_URL}/${GODOT_VERSION}${SUBDIR}/Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM}.zip \
    && wget ${BASE_URL}/${GODOT_VERSION}${SUBDIR}/Godot_v${GODOT_VERSION}-${RELEASE_NAME}_export_templates.tpz \
    && mkdir ~/.cache \
    && mkdir -p ~/.config/godot \
    && mkdir -p ~/.local/share/godot/export_templates/${GODOT_VERSION}.${RELEASE_NAME} \
    && unzip Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM}.zip \
    && mv Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM} /usr/local/bin/godot \
    && unzip Godot_v${GODOT_VERSION}-${RELEASE_NAME}_export_templates.tpz \
    && mv templates/* ~/.local/share/godot/export_templates/${GODOT_VERSION}.${RELEASE_NAME} \
    && rm -f Godot_v${GODOT_VERSION}-${RELEASE_NAME}_export_templates.tpz Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM}.zip