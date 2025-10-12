# Axon C2 Platform

[![Status](https://img.shields.io/badge/Status-In%20Development-orange?style=for-the-badge)]()
[![C++](https://img.shields.io/badge/C%2B%2B-20-blue?style=for-the-badge&logo=cplusplus)]()
[![React](https://img.shields.io/badge/React-18-61dafb?style=for-the-badge&logo=react)]()
[![TypeScript](https://img.shields.io/badge/TypeScript-5.0-3178c6?style=for-the-badge&logo=typescript)]()

> **A next-generation Command and Control platform engineered for real-time UAV telemetry processing, AI-powered perception, and ultra-low-latency mission control.**

## Project Overview

Axon C2 is a sophisticated, full-stack command and control system designed for autonomous vehicle operations. The platform combines cutting-edge C++20 asynchronous programming with modern web technologies to deliver real-time telemetry visualization, AI-powered threat detection, and seamless mission control capabilities.

## Prerequisites

Before you begin, ensure you have the following tools installed on your system:

* **A C++23 Compiler**:
    * **Linux**: Clang++ 17+ or GCC 13+
    * **macOS**: Latest Xcode Command Line Tools
    * **Windows**: Visual Studio 2022
* **Git**: Required for cloning the repository and its submodules.
* **CMake**: Version 3.28 or higher. You can download it from the [official CMake website](https://cmake.org/download/).
* **Ninja**: A fast, small build system. You can download it from the [official Ninja website](https://ninja-build.org/).

## Building the Project

This project uses CMake Presets for a consistent build experience across all platforms.

1.  **Clone the Repository**

    Clone the project and its submodules (vcpkg) with a single command:
    ```bash
    git clone --recurse-submodules [https://github.com/your-username/AxonC2.git](https://github.com/your-username/AxonC2.git)
    cd AxonC2
    ```

2.  **Bootstrap vcpkg**

    This step only needs to be done once to prepare the dependency manager.
    ```bash
    # For Linux / macOS
    ./vcpkg/bootstrap-vcpkg.sh

    # For Windows (PowerShell)
    .\vcpkg\bootstrap-vcpkg.bat
    ```

3.  **Configure the Project**

    Select a preset to generate the build files. For example, to use the Clang preset on Linux:
    ```bash
    cmake --preset linux-clang
    ```
    *You can see a list of all available presets by running `cmake --list-presets`.*

4.  **Build the Project**

    Build the configured project. For example, to build the Debug configuration for the `linux-clang` preset:
    ```bash
    cmake --build --preset linux-clang-debug
    ```

5.  **Run the Executable**

    The executable will be located in the build directory.
    ```bash
    ./build/linux-clang/Debug/AxonC2
    ```

### Architecture Highlights

- **High-Performance Core**: Built with C++20 coroutines and lock-free data structures
- **Real-Time Processing**: Sub-millisecond telemetry ingestion using custom memory pools
- **AI Perception Engine**: NVIDIA TensorRT-optimized inference with hardware-accelerated video decoding  
- **Modern Frontend**: React + TypeScript with WebRTC live streaming and 3D situational displays
- **Scalable Backend**: Boost.Asio event-driven architecture with Redis caching and SQLite persistence

## Key Features

### Core Capabilities
- **MAVLink Protocol Integration** - Real-time UAV telemetry processing from PX4/ArduPilot
- **Live Video Streaming** - WebRTC-based low-latency H.265 video transmission
- **AI-Powered Detection** - GPU-accelerated object detection and event fusion
- **3D Mission Visualization** - Interactive Three.js-based situational awareness
- **Command & Control API** - RESTful interface for vehicle command execution

### Technical Innovations
- **Lock-Free MPMC Queues** - Custom implementation for zero-contention data flow
- **CPU Affinity Optimization** - Thread pinning for deterministic real-time performance  
- **Hardware-Accelerated Pipeline** - NVIDIA NVDEC integration for efficient video processing
- **Distributed Tracing** - OpenTelemetry integration for production observability

## Technology Stack

### Backend (C++20)
- **Networking**: Boost.Asio with coroutines support
- **Data Processing**: Custom allocators and lock-free data structures  
- **AI/ML**: NVIDIA TensorRT for optimized inference
- **Databases**: Redis (real-time cache) + SQLite (persistent storage)
- **Video**: FFmpeg with CUDA acceleration

### Frontend (React/TypeScript)
- **Framework**: React 18 with TypeScript 5.0
- **Build Tool**: Vite for fast development and optimized builds
- **3D Graphics**: Three.js with react-three-fiber
- **Data Visualization**: Plotly.js for real-time telemetry charts
- **Communication**: WebSocket + WebRTC for bi-directional data flow

### Infrastructure & DevOps
- **Containerization**: Multi-stage Docker builds
- **Package Management**: vcpkg for C++ dependencies
- **CI/CD**: GitHub Actions with automated testing
- **Monitoring**: Prometheus + Grafana stack

## Development Roadmap

The project follows a systematic 7-phase development approach:

1. **Foundation & Simulation Environment** - Professional toolchain setup and MAVLink SITL integration
2. **High-Performance C++ Core** - Asynchronous I/O engine with custom data structures  
3. **Data Processing Pipelines** - Telemetry deserialization and dual-storage architecture
4. **AI Perception Engine** - GPU-accelerated video processing and event fusion
5. **Web API Layer** - Real-time streaming and command interfaces
6. **Frontend Development** - Modern React-based mission control interface
7. **Production Hardening** - Security, monitoring, and operational excellence

## Current Status

**Phase 2 - Core Engineering** (In Progress)

Currently implementing the high-performance C++ backend with focus on:
- Boost.Asio networking layer with C++20 coroutines
- Custom lock-free MPMC queue implementation  
- Memory pool allocators for zero-allocation data processing
- Multi-threaded architecture with CPU affinity optimization


---