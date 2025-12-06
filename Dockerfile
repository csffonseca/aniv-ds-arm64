# FROM ubuntu:latest
FROM docker.io/sonroyaalmerol/steamcmd-arm64:latest


# Install SteamCMD

# RUN apt update
# RUN apt install -y software-properties-common
# RUN add-apt-repository multiverse
# RUN dpkg --add-architecture i386
# RUN apt update
# RUN echo steam steam/question select "I AGREE" | debconf-set-selections
# RUN apt install -y steamcmd

# Add server files and entrypoint script
USER 0
RUN apt update
RUN apt install -y --no-install-recommends --no-install-suggests sqlite3 libsqlite3-dev
USER 1000
WORKDIR /home/steam/
ADD --chown=steam ./scripts/entrypoint.sh .
ADD --chown=steam ./scripts/aniv-ds.sh .

# Expose ports
EXPOSE 7776-7779/tcp
EXPOSE 7776-7779/udp

# Box64
ENV BOX64_DYNAREC_BIGBLOCK=0
ENV BOX64_DYNAREC_SAFEFLAGS=2
ENV BOX64_DYNAREC_STRONGMEM=3
ENV BOX64_DYNAREC_FASTROUND=0
ENV BOX64_DYNAREC_FASTNAN=0
ENV BOX64_DYNAREC_X87DOUBLE=1
ENV BOX64_PREFER_EMULATED=1
ENV ARM64_DEVICE=adlink

# Profiler... Could be optimized
# EXPOSE 55000-55495/tcp
# EXPOSE 55000-55495/udp
# EXPOSE 54997/udp
# EXPOSE 54997/tcp

# EXPOSE 35000/udp
# EXPOSE 35000/tcp

# EXPOSE 34997/udp
# EXPOSE 34997/tcp

# EXPOSE 4600/udp
# EXPOSE 4600/tcp

# EXPOSE 54997/udp
# EXPOSE 54997/tcp

# Start server

ENTRYPOINT ["./entrypoint.sh"]
