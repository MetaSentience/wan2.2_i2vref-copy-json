# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.0-base

# install custom nodes into comfyui
# 1) cg-use-everywhere
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/city96/ComfyUI-cg-use-everywhere.git
# 2) ComfyUI-KJNodes
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/kjnodes/kjnodes-comfyui.git
# 3) ComfyUI-VideoHelperSuite (VHS)
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git
# 4) ComfyUI_essentials
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/cubiq/ComfyUI_essentials.git
# models will be loaded from Network Volume via extra_model_paths.yaml
COPY extra_model_paths.yaml /ComfyUI/extra_model_paths.yaml
# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
