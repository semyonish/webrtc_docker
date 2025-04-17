# Сборка WebRTC

## iOS

```console
# создаем переходим в папку для сборки
source <путь до prepare_webrtc.sh>/prepare_webrtc.sh <hash коммита webrtc> ios
cd src
python3 tools_webrtc/ios/build_ios_libs.py
```

Собранный фркеймворк лежит в src/out_ios_libs

## Android

Планируется сборка из докера
Dockerfile есть, но пока не работает :)
