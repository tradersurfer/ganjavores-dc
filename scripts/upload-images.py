import os, glob, time, urllib.request, json

PROJECT_REF = "ogaisocuxygcembgodna"
SERVICE_KEY = open(r"C:\Users\jorda\Downloads\ganjavores-dc-v7\.env.local").read().strip().split('\n')[2].split('=')[1]
BASE_URL = f"https://{PROJECT_REF}.supabase.co/storage/v1/object/public/product-images"

public_dir = r"C:\Users\jorda\Downloads\ganjavores-dc-v7\public\products"
categories = ['flower', 'vapes', 'edibles', 'pre-rolls']

uploaded = 0
failed = 0

for cat in categories:
    folder = os.path.join(public_dir, cat)
    if not os.path.exists(folder):
        continue
    for f in os.listdir(folder):
        if not f.endswith('.png'):
            continue
        
        fpath = os.path.join(folder, f)
        remote_path = f"{cat}/{f}"
        
        try:
            with open(fpath, 'rb') as file_data:
                data = file_data.read()
            
            # Upload to Supabase Storage via REST API
            url = f"{BASE_URL}/{remote_path}?upsert=true"
            req = urllib.request.Request(
                url,
                data=data,
                headers={
                    'Authorization': f'Bearer {SERVICE_KEY}',
                    'apikey': SERVICE_KEY,
                    'Content-Type': 'image/png',
                    'Content-Length': str(len(data))
                },
                method='POST'
            )
            resp = urllib.request.urlopen(req, timeout=15)
            uploaded += 1
        except Exception as e:
            failed += 1
        
        time.sleep(0.05)

print(f"Uploaded: {uploaded}, Failed: {failed}")
