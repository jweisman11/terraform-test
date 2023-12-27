import requests
import json

with open("./secrets.json") as f:
    data = json.load(f)

r = requests.get(
    url=f"{data['API_URL']}/dev/health", headers={"X-API-KEY": data["API_KEY"]}
)

print(r.status_code)
print(r.json())
