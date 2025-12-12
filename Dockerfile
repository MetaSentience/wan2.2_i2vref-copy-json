FROM runpod/worker-comfyui:5.5.0-base

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /ComfyUI/custom_nodes

# VideoHelperSuite
RUN cd /ComfyUI/custom_nodes && \
    git clone --depth 1 https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git

# KJNodes — через GIT_TERMINAL_PROMPT=0
RUN cd /ComfyUI/custom_nodes && \
    GIT_TERMINAL_PROMPT=0 git clone --depth 1 https://github.com/kjnodes/kjnodes-comfyui.git

# Essentials
RUN cd /ComfyUI/custom_nodes && \
    git clone --depth 1 https://github.com/cubiq/ComfyUI_essentials.git

COPY extra_model_paths.yaml /ComfyUI/extra_model_paths.yaml
