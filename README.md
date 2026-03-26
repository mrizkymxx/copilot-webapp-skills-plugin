# 🎯 Webapp Skills Plugin for GitHub Copilot CLI

A curated collection of **9 production-ready webapp development skills** for GitHub Copilot CLI, powered by the [claude-skills](https://github.com/alirezarezvani/claude-skills) repository.

Each skill includes comprehensive workflows, best practices, and code examples from senior engineers. Total: **2,845 lines** of expert guidance across frontend, backend, fullstack, DevOps, and more.

---

## 📦 Included Skills

| Skill | Description | Lines | Expertise |
|-------|-------------|-------|-----------|
| **frontend-development** | React, Vue, Angular, TypeScript, Tailwind CSS | 473 | Senior Frontend Engineer |
| **backend-development** | Node.js, Express, Python, APIs, Database | 365 | Senior Backend Engineer |
| **api-design** | REST, GraphQL, API best practices | 420 | API Design Reviewer |
| **docker-containerization** | Docker, Docker Compose, containerization | 366 | Docker Specialist |
| **devops-automation** | CI/CD, deployment, infrastructure | 323 | Senior DevOps Engineer |
| **database-architecture** | Schema design, migrations, optimization | 289 | Database Designer |
| **fullstack-engineering** | Full-stack web app development | 285 | Senior Fullstack Engineer |
| **testing-qa** | Unit, integration, e2e testing | 177 | Testing & QA Engineer |
| **cicd-pipeline** | GitHub Actions, automation | 147 | CI/CD Pipeline Builder |

**Total:** 2,845 lines of production-ready guidance!

---

## 🚀 Quick Install

### **Method 1: From GitHub (Recommended)**

```bash
# Install directly from GitHub
copilot plugin install mrizkymxx/copilot-webapp-skills-plugin
```

### **Method 2: Local Install**

```bash
# Clone the repository
git clone https://github.com/mrizkymxx/copilot-webapp-skills-plugin.git

# Install locally
copilot plugin install ~/copilot-webapp-skills-plugin
```

---

## 🖥️ Windows Installation

### **Option A: Automated (PowerShell Script)**

```powershell
# Download and run the installer
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mrizkymxx/copilot-webapp-skills-plugin/main/setup-windows.ps1" -OutFile "setup-copilot.ps1"
powershell -ExecutionPolicy Bypass .\setup-copilot.ps1
```

### **Option B: Manual Steps**

```powershell
# 1. Install tools
winget install Git.Git
winget install GitHub.cli

# 2. Login & install Copilot
gh auth login
gh extension install github/gh-copilot

# 3. Clone source repository
cd C:\Users\%USERNAME%\Documents
git clone https://github.com/alirezarezvani/claude-skills.git

# 4. Install plugins
copilot plugin install mrizkymxx/copilot-webapp-skills-plugin
copilot plugin install spark@copilot-plugins
```

---

## 💡 Usage

After installation, skills appear in the interactive Copilot CLI:

1. **Start Copilot:** `gh copilot`
2. **Open menu:** Press `/` (forward slash)
3. **Select Skills:** Choose from the menu
4. **Pick a skill:** Select the skill you need
5. **Start coding:** Copilot now has expert context!

### **Example Workflow**

```bash
# Start interactive mode
gh copilot

# Press "/" and select "Skills"
# Choose "frontend-development"
# Now ask: "Create a React component with TypeScript"
# Copilot responds with senior frontend engineer expertise!
```

---

## 🔄 Update Plugin

### **From GitHub:**
```bash
copilot plugin update mrizkymxx/copilot-webapp-skills-plugin
```

### **Local/Manual:**
```bash
cd ~/copilot-webapp-skills-plugin
git pull
```

---

## 📋 Prerequisites

- **GitHub CLI** (`gh`) - [Install](https://cli.github.com/)
- **GitHub Copilot subscription** - [Sign up](https://github.com/features/copilot)
- **Copilot CLI extension:** `gh extension install github/gh-copilot`
- **claude-skills repository** - Auto-installed or manual: `git clone https://github.com/alirezarezvani/claude-skills.git`

---

## 🎊 Bonus: Install Spark Plugin

Get the official **Spark** plugin for modern frontend templates:

```bash
copilot plugin install spark@copilot-plugins
```

**Spark provides:** React 19 + Vite + Tailwind v4 + shadcn/ui opinionated stack.

**Total skills with both plugins:** 10 (9 webapp + 1 Spark)!

---

## 🛠️ Management Commands

```bash
# List installed plugins
copilot plugin list

# Uninstall this plugin
copilot plugin uninstall webapp-skills

# Reinstall (fresh install)
copilot plugin uninstall webapp-skills
copilot plugin install mrizkymxx/copilot-webapp-skills-plugin
```

## 📚 Credits

Skills sourced from [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills) - 205+ production-ready skills for AI coding agents.

## 📄 License

MIT
