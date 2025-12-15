FROM runpod/worker-comfyui:5.5.0-base
# Triton, нужен SageAttention
RUN pip install --no-cache-dir "triton>=3.0.0"

# Инструменты
RUN apt-get update && \
    apt-get install -y git curl unzip && \
    rm -rf /var/lib/apt/lists/*

# Собрать SageAttention из исходников
RUN git clone https://github.com/thu-ml/SageAttention.git /tmp/SageAttention && \
    cd /tmp/SageAttention && \
    EXT_PARALLEL=4 NVCC_APPEND_FLAGS="--threads 8" MAX_JOBS=32 python setup.py install && \
    rm -rf /tmp/SageAttention
    
# Установить OpenCV для Python
RUN pip install --no-cache-dir opencv-python-headless imageio-ffmpeg

# Папка для кастомных нод
RUN mkdir -p /comfyui/custom_nodes

# --- ComfyUI-VideoHelperSuite (VHS) ---
RUN cd /comfyui/custom_nodes && \
    git clone --depth 1 https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git

# --- ComfyUI-KJNodes (через codeload, самый стабильный способ) ---
RUN cd /comfyui/custom_nodes && \
    curl -L https://codeload.github.com/kijai/ComfyUI-KJNodes/zip/refs/heads/main -o kjnodes.zip && \
    unzip kjnodes.zip && \
    mv ComfyUI-KJNodes-main ComfyUI-KJNodes && \
    rm kjnodes.zip

# --- ComfyUI Essentials ---
RUN cd /comfyui/custom_nodes && \
    git clone --depth 1 https://github.com/cubiq/ComfyUI_essentials.git

# --- пути к моделям ---
COPY extra_model_paths.yaml /comfyui/extra_model_paths.yaml
