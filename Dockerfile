FROM runpod/worker-comfyui:5.5.0-base

# --- tools for installing custom nodes ---
USER root
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /ComfyUI/custom_nodes
USER root   # базовый образ всё равно под root, оставим так

# --- custom nodes ---

# ComfyUI-VideoHelperSuite (VHS)
RUN cd /ComfyUI/custom_nodes && \
    git clone --depth 1 https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git

# ComfyUI-KJNodes
RUN cd /ComfyUI/custom_nodes && \
    git clone --depth 1 https://github.com/kjnodes/kjnodes-comfyui.git

# ComfyUI_essentials
RUN cd /ComfyUI/custom_nodes && \
    git clone --depth 1 https://github.com/cubiq/ComfyUI_essentials.git

# --- models live on Network Volume ---
COPY extra_model_paths.yaml /ComfyUI/extra_model_paths.yaml
