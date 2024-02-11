# sml-test

## 実行手順

 -  イメージをビルド
    -  `docker build --pull --rm -f "Dockerfile" -t smls:latest "." `
 - コンテナを立ち上げ
    -  `docker run -it  --name sml  -v sml_vol:/sml smls:latest`
 -  マウントされた場所を調べる
    - ホスト側で`docker inspect  sml`
       -  出力されたjsonの中のMounts.Sourceを探す

```例.json
     .......
          "Mounts": [
                 {
                     "Type": "volume",
                     "Name": "sml_vol",
                     "Source": "/var/snap/docker/common/var-lib-docker/volumes/sml_vol/_data",  <= これ
                     "Destination": "/sml",
                     "Driver": "local",
     ...........
```

 - ソースコードを同期させる
    -  プロジェクト/src 配下にソースコードを置くなら、 `sudo rsync -av  ./src/ /var/snap/docker/common/var-lib-docker/volumes/sml_vol/_data`
  -  コンテナの中にコンパイラは入っているので、後はコンパイルするだけ
     - `smlsharp hello.sml`
     - `./a.out    >>  "Hello World!"`