FROM ubuntu:20.04 as flutter-builder

# Setup 
RUN apt-get update
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y curl git wget unzip pkg-config libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3 libgtk-3-dev ninja-build cmake clang liblzma-dev
RUN apt-get clean

# Install Flutter
ENV FLUTTER_HOME=/usr/local/flutter
ENV FLUTTER_VERSION=3.3.9

RUN git clone --depth 1 --branch ${FLUTTER_VERSION} https://github.com/flutter/flutter.git ${FLUTTER_HOME}
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
RUN flutter doctor -v
RUN flutter config --enable-web

# Copy files to container
COPY . /usr/local/bin/app/
WORKDIR /usr/local/bin/app/

# Build flutter web
RUN flutter clean
RUN flutter pub get
RUN flutter build web --web-renderer canvaskit --release -t lib/flavor/dev/main_dev.dart --verbose

# Setup nginx
FROM nginx:1.23
COPY --from=flutter-builder /usr/local/bin/app/build/web/ /usr/share/nginx/html/
COPY ./server/flutter-web.conf /etc/nginx/conf.d/
EXPOSE 80
