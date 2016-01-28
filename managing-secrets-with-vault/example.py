import requests

# 4f636675-297c-8ae3-853f-f0eb7a249562
headers = {"X-Vault-Token": "aaa40c93-bb0e-7c20-083e-4afbc3e52517"}

r = requests.get('http://127.0.0.1:8200/v1/secret/digitalocean-api-key', headers=headers)
json_response = r.json()
print json_response
if r.status_code == 200:
	api_key = json_response.get('data',{}).get('value', "")

	print api_key
