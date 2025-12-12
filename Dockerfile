FROM runpod/worker-comfyui:5.5.0-base

RUN apt-get update && apt-get install -y git curl unzip && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /ComfyUI/custom_nodes

# VHS
RUN cd /ComfyUI/custom_nodes && \
    git clone --depth 1 https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git

# KJNodes — через ZIP (обход глюка RunPod)
RUN cd /ComfyUI/custom_nodes && \
    curl -L https://github.com/kjnodes/kjnodes-comfyui/archive/refs/heads/main.zip -o kj.zip && \
    unzip kj.zip && \
    mv kjnodes-comfyui-main kjnodes-comfyui && \
    rm kj.zip

# Essentials
RUN cd /ComfyUI/custom_nodes && \
    git clone --depth 1 https://github.com/cubiq/ComfyUI_essentials.git

COPY extra_model_paths.yaml /ComfyUI/extra_model_paths.yaml
