# 🐧 Fedora Workstation Setup

Fully automated setup of my development environment on **Fedora** using **Ansible** and **Make**.  
Ideal for reinstalling the system or setting up a new machine in just a few commands ⚡

## ✨ What this playbook does

- 🧭 **Updates the operating system**
- 🔑 Restores my **SSH keys** (optional, via local or manual backup)
- 🐚 Installs and configures **Zsh**, [Oh My Zsh](https://ohmyz.sh/) + [Spaceship](https://github.com/spaceship-prompt/spaceship-prompt) theme + useful plugins (git, kubectl, aws, etc.)
- 🛠️ Installs development tools:
  - Git + GitHub CLI
  - VS Code
  - IntelliJ Toolbox (Flatpak)
- 🌐 Installs general-purpose applications:
  - Brave Browser
  - Podman Desktop
  - Spotify
  - Discord
  - Telegram
  - Solaar
  - Steam
- 📦 Enables **RPM Fusion** and **Flathub**
- 🧰 Performs some recommended post-installation tweaks for Fedora:
  - Multimedia codecs
  - DNF adjustments (parallel downloads, fastestmirror)
  - Minor environment optimizations

## 📁 Project Structure

```
fedora-setup/
├─ Makefile
├─ site.yml
├─ inventory/
│  └─ hosts
├─ group_vars/
│  └─ all.yml
├─ tasks/
│  ├─ 00_prereqs.yml
│  ├─ 01_repos.yml
│  ├─ 02_update.yml
│  ├─ 03_packages_rpm.yml
│  ├─ 04_flatpaks.yml
│  ├─ 05_shell.yml
│  ├─ 06_ssh.yml
│  └─ 90_post_install.yml
└─ files/
   └─ ssh/
      └─ .gitkeep
```

## 🚀 How to use

### 1️⃣ Install basic dependencies

```bash
sudo dnf -y install ansible git curl wget python3-dnf-plugins-core
```

Or use the Makefile:

```bash
make bootstrap
```

### 2️⃣ Adjust variables

Edit `group_vars/all.yml` and customize:

* Zsh plugins
* List of Flatpak and RPM packages
* Target user (`target_user`)
* Path to restore SSH, if you plan to use it

### 3️⃣ Configure your SSH keys (optional)

For security, **keys are NOT stored in the repository**.
You can restore them manually or mount an external drive and copy them to `~/.ssh` before running the playbook.

> 🚫 Never commit private keys to the repo.

### 4️⃣ Run the automation

```bash
make run
```

👉 This runs the `site.yml` playbook locally, with sudo when necessary.

If you want to test without applying changes:

```bash
make check
```

## ⚠️ Important notes

* The playbook uses **Flatpak** for most apps (Spotify, Discord, Steam, etc.) — this is intentional, as it simplifies updates and sandboxing.
* Brave and VS Code come from official repositories (added automatically).
* SSH is handled with care: by default, the `files/ssh` directory is ignored in `.gitignore`:

  ```
  files/ssh/*
  !files/ssh/.gitkeep
  ```
* You can enhance the SSH part later (e.g., use Ansible Vault, or generate new keys automatically).

## 📝 Manual post-installation (quick checklist)

* [ ] Log in to IntelliJ Toolbox and install desired IDEs
* [ ] Configure extensions in VS Code (sync if possible)
* [ ] Log in to Flatpak apps (Spotify, Discord, Telegram, Steam)
* [ ] Adjust GNOME Tweaks, themes, or extensions if desired
* [ ] Configure `gh auth login` for the GitHub CLI
* [ ] Test SSH access (`ssh-add -l` and `ssh git@github.com`)

## 🧠 References

* [Things To Do After Installing Fedora – FOSS Post](https://fosspost.org/things-to-do-after-installing-fedora)
* [Fedora Docs](https://docs.fedoraproject.org/)
* [Oh My Zsh](https://ohmyz.sh/)
* [Ansible Documentation](https://docs.ansible.com/)

## 🧼 Cleanup and security

* 🚀 To reinstall, just format Fedora, clone the repo, and run `make run`.
* 🔑 Never leave private keys versioned. Use a flash drive, 1Password/Bitwarden CLI, or Ansible Vault if you want to automate.
* 💾 If you want to sync configs (zshrc, VS Code settings, etc.), use a separate repository with public or encrypted dotfiles.

## 🧑‍💻 Author

Made with :coffee:, patience, and too many reinstalls 😅
Feel free to adapt, fork, and improve.