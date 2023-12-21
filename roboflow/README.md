# Roboflow

## Inference
```bash
docker pull roboflow/roboflow-inference-server-gpu

docker run -it --network=host --gpus=all roboflow/roboflow-inference-server-gpu:latest

docker run -it --network=host --gpus=all -v $(pwd)/inference-cache:/tmp/cache roboflow/roboflow-inference-server-gpu:latest

ROBOFLOW_API_KEY=XGup4Bmn7cj7FWuJaOIM && \
docker run -it --network=host --gpus=all -e ROBOFLOW_API_KEY=$ROBOFLOW_API_KEY -v $(pwd)/inference-cache:/tmp/cache roboflow/roboflow-inference-server-gpu:latest
```

### Use CogVLM
Configure an API Key:
```bash
export ROBOFLOW_API_KEY=XGup4Bmn7cj7FWuJaOIM
```

Run the Python script:
```python
import base64
import os
from PIL import Image
import requests

PORT = 9001
ROBOFLOW_API_KEY = os.environ["ROBOFLOW_API_KEY"]
IMAGE_PATH = "forklift.png"


def encode_base64(image_path):
    with open(image_path, "rb") as image:
        x = image.read()
        image_string = base64.b64encode(x)

    return image_string.decode("ascii")

# prompt = "Read the serial number."
# prompt = "Is the package dented?"
# prompt = "Is there luggage on the airport tarmac?"
prompt = "Is there a forklift close to a conveyor belt?"

infer_payload = {
    "image": {
        "type": "base64",
        "value": encode_base64(IMAGE_PATH),
    },
    "api_key": ROBOFLOW_API_KEY,
    "prompt": prompt,
}

results = requests.post(
    f"http://localhost:{PORT}/llm/cogvlm",
    json=infer_payload,
)

print(results.json())
```
