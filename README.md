# 🌐 TSA Model Rocket Dashboard

A real-time web dashboard built with **Flutter Web**, powered by **Firebase Firestore** and **Node.js**, and deployed locally using **Docker + Nginx**.

---

## 🧠 Architecture Overview

This project is built using the following architecture:

- **Backend (Node.js API)**:
  - Hosted on [Render.com](https://render.com)
  - Handles data insertion (e.g., temp, humidity, IMU, battery level, etc.)
  - Exposed as a RESTful API for any external data sources (sensors, devices, other software or hardware platforms)

- **Database**:
  - [Firebase Firestore](https://firebase.google.com/docs/firestore)
  - Stores all dashboard-related data
  - Supports real-time listeners for live UI updates

- **Frontend (Flutter Web App)**:
  - Built using Flutter for a responsive, cross-platform experience
  - Real-time updates via Firestore Streams
  - Deployed locally using Nginx inside a Docker container

- **Automation (Bash Script)**:
  - One-step command to build & run the Docker container with configured nginx server 

### 📦 System Architecture

![System Architecture](./assets/dashboard_architecture_components.png)

---

## 📸 Dashboard UI Screenshot

![Dashboard Screenshot](./assets/dashboard_screenShot.png)

## 📸 Dashboard UI Recording App Behavior

![Dashboard Recorded Test](./assets/TSA_Dashboard_Recording.mp4)

---

## 🚀 Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/yourusername/flutter_dashboard_web.git
cd {repoName}
./run.sh {YOUR_PORT_NUMBER}
