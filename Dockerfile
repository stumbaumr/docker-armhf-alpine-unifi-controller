FROM armhf/debian:latest

RUN echo "deb http://www.ubnt.com/downloads/unifi/debian unifi5 ubiquiti" > /etc/apt/sources.list.d/ubnt.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 && \
    apt-get update -y && \
    apt-get install -y unifi && \
    echo 'ENABLE_MONGODB=no' >> /etc/mongodb.conf && \
    rm /usr/lib/unifi/lib/native/Linux/armhf/libubnt_webrtc_jni.so && \
    rm /usr/lib/unifi/lib/snappy-java-1.0.5.jar

ADD http://central.maven.org/maven2/org/xerial/snappy/snappy-java/1.1.2/snappy-java-1.1.2.jar /usr/lib/unifi/lib/snappy-java-1.0.5.jar

VOLUME /usr/lib/unifi/data

EXPOSE  8443 8880 8080

WORKDIR /usr/lib/unifi

CMD ["java", "-Xmx256M", "-jar", "/usr/lib/unifi/lib/ace.jar", "start"]
