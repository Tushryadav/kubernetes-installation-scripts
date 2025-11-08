# 🚀 Kubernetes Installation using Automated Bash Scripts

This repository provides **automated scripts** to quickly install and configure a **Kubernetes v1.30** cluster using **CRI-O** as the container runtime on **Ubuntu-based systems**.

---

## 🧩 Features

- ✅ Automatic **CRI-O installation**  
- ✅ Kubernetes components (**kubeadm, kubelet, kubectl**) setup  
- ✅ **Master (Control Plane)** initialization  
- ✅ **Calico CNI** network deployment  

---

## 📂 Files Overview

| File Name     | Description |
|----------------|-------------|
| `common.sh`   | Common setup script for both Master and Worker nodes. Installs CRI-O, Kubernetes tools, and configures networking. |
| `master25.sh` | Control Plane setup script. Initializes the Kubernetes Master and deploys the Calico network. |

---

## ⚙️ Prerequisites

Before running the scripts, ensure the following:

- **Operating System:** Ubuntu 20.04 or later (fresh installation recommended)  
- **Privileges:** Run as a user with `sudo` privileges  
- **Internet Access:** Required for downloading Kubernetes and CRI-O packages  

### 💻 Minimum System Requirements

| Node Type   | CPU | RAM    |
|--------------|-----|--------|
| Master Node  | 2 CPU cores | 4GB+ RAM |
| Worker Node  | 2 CPU cores | 2GB+ RAM |

---

## 🧠 Step-by-Step Installation Guide

### **Step 1: Download the Repository**

Clone the repository and navigate into the directory:

```bash
git clone https://github.com/<your-username>/k8s-auto-install.git
cd k8s-auto-install
