# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.0-base

# install custom nodes into comfyui
# (no custom nodes to install)

# models will be loaded from Network Volume via extra_model_paths.yaml
COPY extra_model_paths.yaml /ComfyUI/extra_model_paths.yaml

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
