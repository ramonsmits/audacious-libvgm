FROM fedora:43 AS build
RUN dnf install -y audacious-devel cmake gcc g++ make zlib-devel && dnf clean all

COPY . /build/audacious-libvgm
WORKDIR /build/audacious-libvgm

RUN cmake -B build -DCMAKE_BUILD_TYPE=Release && \
    cmake --build build -j$(nproc)

FROM scratch
COPY --from=build /build/audacious-libvgm/build/libvgm.so /libvgm.so
