# This Dockerfile sets up a development environment for the AxonC2 project.

FROM ubuntu:24.04

# Set the default shell to bash for more powerful scripting
SHELL ["/bin/bash", "-c"]

LABEL Description="A next-generation Command and Control platform engineered for real-time UAV telemetry processing, AI-powered perception, and ultra-low-latency mission control."
LABEL Author="JamesOdukoya"

# Define a non-root user
ARG USERNAME=dev
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Install essential system packages and build tools
# Includes all dependencies for the entire build process, including 'pkg-config'.
RUN apt-get update && apt-get -y --no-install-recommends install \
    build-essential \
    ca-certificates \
    lsb-release \
    software-properties-common \
    gnupg \
    curl \
    zip \
    unzip \
    tar \
    pkg-config \
    sudo \
    bash \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install Clang 19
RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh 19 all && \
    rm llvm.sh && \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-19 100 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-19 100 && \
    update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-19 100 && \
    update-alternatives --install /usr/bin/lldb lldb /usr/bin/lldb-19 100 && \
    update-alternatives --install /usr/bin/lld lld /usr/bin/lld-19 100 && \
    update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-19 100

# Install Ninja
RUN wget https://github.com/ninja-build/ninja/releases/download/v1.13.1/ninja-linux.zip && \
    unzip ninja-linux.zip && \
    mv ninja /usr/bin/ninja && \
    chmod +x /usr/bin/ninja && \
    rm ninja-linux.zip

# Install CMake
RUN wget https://github.com/Kitware/CMake/releases/download/v4.1.2/cmake-4.1.2-linux-x86_64.sh && \
    chmod +x cmake-4.1.2-linux-x86_64.sh && \
    ./cmake-4.1.2-linux-x86_64.sh --prefix=/usr/local --skip-license && \
    rm cmake-4.1.2-linux-x86_64.sh

# Create the user BEFORE you need to reference them
RUN if getent passwd $USER_UID > /dev/null; then userdel $(getent passwd $USER_UID | cut -d: -f1); fi && \
    if getent group $USER_GID > /dev/null; then groupdel $(getent group $USER_GID | cut -d: -f1); fi && \
    groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

# Clone vcpkg, bootstrap it, and set the correct ownership
RUN git clone https://github.com/microsoft/vcpkg.git /opt/vcpkg && \
    /opt/vcpkg/bootstrap-vcpkg.sh && \
    chown -R $USERNAME:$USERNAME /opt/vcpkg

# --- Switch to non-root user for subsequent steps ---
USER $USERNAME

# Set the standard working directory for the project's source code
WORKDIR /workspace

# Install C++ dependencies using vcpkg
COPY --chown=dev:dev vcpkg.json ./
RUN /opt/vcpkg/vcpkg install

# Copy the rest of the project source code into the container
COPY --chown=dev:dev . .