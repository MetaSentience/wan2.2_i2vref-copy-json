import runpod
import requests
import os
import json
import time

COMFY_HOST = "http://127.0.0.1:8188"


def wait_for_result(prompt_id):
    while True:
        r = requests.get(f"{COMFY_HOST}/history/{prompt_id}")
        r.raise_for_status()
        data = r.json()
        if prompt_id in data and data[prompt_id].get("status", {}).get("completed"):
            return data[prompt_id]
        time.sleep(1)


def handler(job):
    inp = job["input"]

    # ожидаем, что клиент присылает уже готовый ComfyUI prompt (workflow API-формата)
    prompt = inp["prompt"]

    # отправляем в локальный ComfyUI внутри контейнера
    r = requests.post(f"{COMFY_HOST}/prompt", json={"prompt": prompt})
    r.raise_for_status()
    prompt_id = r.json()["prompt_id"]

    result = wait_for_result(prompt_id)

    # просто возвращаем history целиком; позже можно разобрать и вытащить файлы
    return {"prompt_id": prompt_id, "history": result}


runpod.serverless.start({"handler": handler})
