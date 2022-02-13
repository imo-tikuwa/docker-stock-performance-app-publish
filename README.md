# docker-stock-performance-app-publish

## 環境構築手順
wsl2(Ubuntu-20.04)環境で以下の手順で構築できると思います。  
※makeコマンドが使用できるようbuild-essentialのインストールが必要
```
git clone --recurse-submodules https://github.com/imo-tikuwa/docker-stock-performance-app-publish.git
cd docker-stock-performance-app-publish
cp .env.example .env
make init
```
