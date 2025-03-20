Install Orbit

Download https://github.com/gulien/orbit/releases

```
curl -Ls -O https://github.com/gulien/orbit/releases/download/v3.3.0/orbit_Linux_x86_64.tar.gz
tar -xzf orbit*.tar.gz orbit
sudo mv ./orbit /usr/local/bin && chmod +x /usr/local/bin/orbit
orbit run generate

cp .env.example .env
docker compose up
```


- https://github.com/gulien/orbit?tab=readme-ov-file
- https://github.com/thecodingmachine/docker-images-php/blob/v4/utils/Dockerfile.slim.blueprint
