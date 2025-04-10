#Grabbed from wilicc/gpu-burn

ARG CUDA_VERSION=12.8.1
ARG IMAGE_DISTRO=ubuntu24.04

FROM nvidia/cuda:${CUDA_VERSION}-devel-${IMAGE_DISTRO} AS builder

WORKDIR /build

COPY . /build/

RUN make

FROM nvidia/cuda:${CUDA_VERSION}-runtime-${IMAGE_DISTRO}

COPY --from=builder /build/gpu_burn /app/
COPY --from=builder /build/compare.ptx /app/

WORKDIR /app

CMD ["./gpu_burn", "-m 90%", "-tc", "3600"]