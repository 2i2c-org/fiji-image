FROM quay.io/jupyter/minimal-notebook:2024-06-24

USER root

COPY setup-scripts /opt/setup-scripts/

# Set DISPLAY env variable, so processes know where to open GUI windows.
# Allows python processes running in notebooks to open windows in the GUI.
ENV DISPLAY=":1.0"

# Setup Linux Desktop
RUN /opt/setup-scripts/setup-linux-desktop.bash

# Setup Fiji
RUN /opt/setup-scripts/setup-fiji.bash

COPY startup-scripts /usr/local/bin/start-notebook.d/

# env variables used by downstream images for setting up desktop files or
# mime associations. Consumed by the startup-scripts in startup-scripts/
ENV DESKTOP_FILES_DIR /opt/desktop-files
ENV MIME_FILES_DIR /opt/mime-files
RUN mkdir -p ${DESKTOP_FILES_DIR} ${MIME_FILES_DIR}

USER ${NB_UID}

COPY fiji.desktop ${DESKTOP_FILES_DIR}/fiji.desktop
# Autostart fiji on startup
COPY fiji.desktop /etc/xdg/autostart/fiji.desktop

RUN python -m pip install --no-cache jupyter-remote-desktop-proxy
