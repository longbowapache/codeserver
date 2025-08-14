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

USER abc
# Pre-install the official Microsoft Python and Jupyter extensions for VS Code.
# This allows you to open and run .ipynb files directly in the code-server UI.
RUN /app/code-server/bin/code-server --install-extension ms-python.python && \
    /app/code-server/bin/code-server --install-extension ms-python.debugpy && \
    /app/code-server/bin/code-server --install-extension ms-toolsai.jupyter && \
    /app/code-server/bin/code-server --install-extension ms-toolsai.vscode-jupyter-cell-tags && \
    /app/code-server/bin/code-server --install-extension ms-toolsai.jupyter-keymap && \
    /app/code-server/bin/code-server --install-extension ms-toolsai.jupyter-renderers && \
    /app/code-server/bin/code-server --install-extension ms-toolsai.vscode-jupyter-slideshow && \
    /app/code-server/bin/code-server --install-extension vscodevim.vim && \
    /app/code-server/bin/code-server --install-extension ms-python.autopep8 && \
    # /app/code-server/bin/code-server --install-extension ms-toolsai.datawrangler && \
    # /app/code-server/bin/code-server --install-extension google.geminicodeassist && \
    /app/code-server/bin/code-server --install-extension mhutchie.git-graph && \
    /app/code-server/bin/code-server --install-extension golang.go

USER root