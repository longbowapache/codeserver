# Start with the official linuxserver/code-server image
FROM lscr.io/linuxserver/code-server:latest

#
# --- Begin Customizations ---
#

# Switch to the root user to perform installations
USER root

# Update package list and install Python 3 and pip
# Using --no-install-recommends keeps the image smaller
# Finally, clean up the apt cache to reduce final image size
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Use pip to install JupyterLab and the classic Notebook
# Using --no-cache-dir prevents pip from storing a cache, saving space
RUN pip3 install --no-cache-dir --break-system-packages jupyterlab notebook