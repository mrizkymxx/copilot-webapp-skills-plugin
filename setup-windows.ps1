# ╔═══════════════════════════════════════════════════════════════╗
# ║     🚀 COPILOT SKILLS INSTALLER FOR WINDOWS                   ║
# ╠═══════════════════════════════════════════════════════════════╣
# ║  Auto-install GitHub Copilot CLI + Webapp Skills Plugin      ║
# ║  Save file as: setup-copilot-skills.ps1                       ║
# ║  Run: powershell -ExecutionPolicy Bypass .\setup.ps1          ║
# ╚═══════════════════════════════════════════════════════════════╝

Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   🚀 GitHub Copilot CLI + Skills - Windows Installer         ║" -ForegroundColor Cyan
Write-Host "╚═══════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "⚠️  WARNING: Not running as Administrator" -ForegroundColor Yellow
    Write-Host "   Some installations may fail. Consider running as Admin." -ForegroundColor Yellow
    Write-Host ""
    $continue = Read-Host "Continue anyway? (y/n)"
    if ($continue -ne "y") {
        exit
    }
}

# Step 1: Check/Install Git
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
Write-Host "📦 STEP 1: Installing Git..." -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray

if (Get-Command git -ErrorAction SilentlyContinue) {
    Write-Host "✅ Git already installed: $(git --version)" -ForegroundColor Green
} else {
    Write-Host "Installing Git..." -ForegroundColor Cyan
    winget install --id Git.Git -e --source winget --silent
    
    # Refresh PATH
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    
    if (Get-Command git -ErrorAction SilentlyContinue) {
        Write-Host "✅ Git installed successfully!" -ForegroundColor Green
    } else {
        Write-Host "❌ Git installation failed. Please install manually." -ForegroundColor Red
        exit 1
    }
}

# Step 2: Check/Install GitHub CLI
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
Write-Host "📦 STEP 2: Installing GitHub CLI..." -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray

if (Get-Command gh -ErrorAction SilentlyContinue) {
    Write-Host "✅ GitHub CLI already installed: $(gh --version)" -ForegroundColor Green
} else {
    Write-Host "Installing GitHub CLI..." -ForegroundColor Cyan
    winget install --id GitHub.cli -e --source winget --silent
    
    # Refresh PATH
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    
    if (Get-Command gh -ErrorAction SilentlyContinue) {
        Write-Host "✅ GitHub CLI installed successfully!" -ForegroundColor Green
    } else {
        Write-Host "❌ GitHub CLI installation failed. Please install manually." -ForegroundColor Red
        exit 1
    }
}

# Step 3: GitHub Authentication
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
Write-Host "🔐 STEP 3: GitHub Authentication..." -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray

$ghStatus = gh auth status 2>&1
if ($ghStatus -match "Logged in") {
    Write-Host "✅ Already logged in to GitHub" -ForegroundColor Green
} else {
    Write-Host "Please login to GitHub..." -ForegroundColor Cyan
    Write-Host "A browser window will open. Follow the instructions." -ForegroundColor Cyan
    gh auth login
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ GitHub login successful!" -ForegroundColor Green
    } else {
        Write-Host "❌ GitHub login failed. Please run: gh auth login" -ForegroundColor Red
        exit 1
    }
}

# Step 4: Install Copilot CLI Extension
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
Write-Host "🤖 STEP 4: Installing GitHub Copilot CLI..." -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray

$extensions = gh extension list 2>&1
if ($extensions -match "gh-copilot") {
    Write-Host "✅ Copilot CLI already installed" -ForegroundColor Green
} else {
    Write-Host "Installing Copilot CLI extension..." -ForegroundColor Cyan
    gh extension install github/gh-copilot
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Copilot CLI installed successfully!" -ForegroundColor Green
    } else {
        Write-Host "❌ Copilot CLI installation failed." -ForegroundColor Red
        exit 1
    }
}

# Step 5: Clone claude-skills repository
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
Write-Host "📚 STEP 5: Cloning claude-skills repository..." -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray

$documentsPath = [Environment]::GetFolderPath("MyDocuments")
$claudeSkillsPath = Join-Path $documentsPath "claude-skills"

if (Test-Path $claudeSkillsPath) {
    Write-Host "✅ claude-skills already exists at: $claudeSkillsPath" -ForegroundColor Green
    Write-Host "   Pulling latest changes..." -ForegroundColor Cyan
    Push-Location $claudeSkillsPath
    git pull
    Pop-Location
} else {
    Write-Host "Cloning repository..." -ForegroundColor Cyan
    Push-Location $documentsPath
    git clone https://github.com/alirezarezvani/claude-skills.git
    Pop-Location
    
    if (Test-Path $claudeSkillsPath) {
        Write-Host "✅ claude-skills cloned successfully!" -ForegroundColor Green
    } else {
        Write-Host "❌ Failed to clone claude-skills." -ForegroundColor Red
        exit 1
    }
}

# Step 6: Install webapp-skills plugin
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
Write-Host "🎯 STEP 6: Installing Webapp Skills Plugin..." -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray

Write-Host "Installing from GitHub: mrizkymxx/copilot-webapp-skills-plugin" -ForegroundColor Cyan

# Note: copilot binary is in a specific location
$copilotBinary = "$env:LOCALAPPDATA\GitHub CLI\copilot\copilot.exe"

if (-not (Test-Path $copilotBinary)) {
    Write-Host "⚠️  Copilot binary not found. Running 'gh copilot' once to download..." -ForegroundColor Yellow
    # This will trigger the download
    Start-Process -FilePath "gh" -ArgumentList "copilot","--help" -Wait -NoNewWindow
    Start-Sleep -Seconds 3
}

if (Test-Path $copilotBinary) {
    Write-Host "Installing webapp-skills plugin..." -ForegroundColor Cyan
    & $copilotBinary plugin install mrizkymxx/copilot-webapp-skills-plugin
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Webapp Skills plugin installed!" -ForegroundColor Green
    } else {
        Write-Host "⚠️  Plugin installation may have issues. Try manually:" -ForegroundColor Yellow
        Write-Host "   gh copilot" -ForegroundColor Yellow
        Write-Host "   Then run: copilot plugin install mrizkymxx/copilot-webapp-skills-plugin" -ForegroundColor Yellow
    }
} else {
    Write-Host "⚠️  Copilot binary not ready. Install plugin manually:" -ForegroundColor Yellow
    Write-Host "   1. Run: gh copilot" -ForegroundColor Yellow
    Write-Host "   2. Then: copilot plugin install mrizkymxx/copilot-webapp-skills-plugin" -ForegroundColor Yellow
}

# Step 7: Install Spark plugin
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
Write-Host "✨ STEP 7: Installing Spark Plugin (Official)..." -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray

if (Test-Path $copilotBinary) {
    Write-Host "Installing Spark plugin..." -ForegroundColor Cyan
    & $copilotBinary plugin install spark@copilot-plugins
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Spark plugin installed!" -ForegroundColor Green
    } else {
        Write-Host "⚠️  Spark installation may have issues. Try manually." -ForegroundColor Yellow
    }
}

# Summary
Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                    ✅ INSTALLATION COMPLETE!                  ║" -ForegroundColor Green
Write-Host "╠═══════════════════════════════════════════════════════════════╣" -ForegroundColor Green
Write-Host "║                                                               ║" -ForegroundColor Green
Write-Host "║  🎉 You now have:                                             ║" -ForegroundColor Green
Write-Host "║     • GitHub CLI (gh)                                         ║" -ForegroundColor Green
Write-Host "║     • GitHub Copilot CLI                                      ║" -ForegroundColor Green
Write-Host "║     • 9 Webapp Skills                                         ║" -ForegroundColor Green
Write-Host "║     • 1 Spark Skill                                           ║" -ForegroundColor Green
Write-Host "║                                                               ║" -ForegroundColor Green
Write-Host "║  🚀 To use:                                                   ║" -ForegroundColor Green
Write-Host "║     1. Run: gh copilot                                        ║" -ForegroundColor Green
Write-Host '║     2. Press "/" (forward slash)                              ║' -ForegroundColor Green
Write-Host "║     3. Select 'Skills' from menu                              ║" -ForegroundColor Green
Write-Host "║     4. Choose a skill!                                        ║" -ForegroundColor Green
Write-Host "║                                                               ║" -ForegroundColor Green
Write-Host "║  💡 Skills available:                                         ║" -ForegroundColor Green
Write-Host "║     • frontend-development                                    ║" -ForegroundColor Green
Write-Host "║     • backend-development                                     ║" -ForegroundColor Green
Write-Host "║     • fullstack-engineering                                   ║" -ForegroundColor Green
Write-Host "║     • devops-automation                                       ║" -ForegroundColor Green
Write-Host "║     • api-design                                              ║" -ForegroundColor Green
Write-Host "║     • database-architecture                                   ║" -ForegroundColor Green
Write-Host "║     • testing-qa                                              ║" -ForegroundColor Green
Write-Host "║     • docker-containerization                                 ║" -ForegroundColor Green
Write-Host "║     • cicd-pipeline                                           ║" -ForegroundColor Green
Write-Host "║     • spark-app-template (React+Vite+Tailwind)                ║" -ForegroundColor Green
Write-Host "║                                                               ║" -ForegroundColor Green
Write-Host "╚═══════════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "🎯 Ready to code! Type: gh copilot" -ForegroundColor Cyan
Write-Host ""
