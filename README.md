<p align="center"><img src="art/banner-2x.png"></p>

## A Fresh macOS Setup

This guide will walk you through setting up a fresh macOS system. If you are looking to build your own dotfiles from scratch, follow the instructions below to customize everything to your liking.

### Backup Your Data

Before you migrate to a new Mac or wipe your old machine, ensure your data is backed up. Here’s a checklist of things to verify:

* **Git repositories**: Commit and push any changes/branches.
* **Documents**: Save all important files from non-iCloud directories.
* **Non-synced apps**: Back up work from apps that aren’t synced via iCloud.
* **Mackup**: Ensure Mackup is updated and run `mackup backup` to sync preferences.

### Setting Up Your New Mac

Once your backup is ready, follow these steps to set up your new Mac:

1. **Update macOS**: Make sure you’re on the latest version.

2. **Setup SSH Key**:
   Generate a new public and private SSH key by running:

   ```bash
   curl https://raw.githubusercontent.com/FainiDenis/dotfiles/HEAD/ssh.sh | sh -s "<your-email-address>"
   ```

3. **Clone the repository**:

   ```bash
   git clone --recursive https://github.com/FainiDenis/dotfiles.git ~/.dotfiles
   ```

4. **Run the installation script**:

   ```bash
   bash -c "$(curl -fsSL https://raw.githubusercontent.com/FainiDenis/dotfiles/main/fresh.sh)"
   ```
   or

   ```bash
   cd ~/.dotfiles && ./fresh.sh
   ```

5. **Install Herd.app**: Open the app and follow the installation steps.

6. **Restore preferences with Mackup**:

   ```bash
   mackup restore
   ```

7. **Restart your computer** to finish the process.

Now your Mac is ready to go!

💡 You can use a different location for your dotfiles (other than `~/.dotfiles`). Just ensure you update the references in the `.zshrc` and `fresh.sh` files accordingly.

---

## Special Thanks

This setup is based on the work of many amazing contributors:

* [Dries Vints](https://github.com/driesvints) for the original dotfiles setup that inspired this repo.
* [Zach Holman](https://github.com/holman) and [Mathias Bynens](https://github.com/mathiasbynens) for their dotfiles inspiration.
* [Sourabh Bajaj](https://github.com/sb2nov) for his detailed macOS setup guide.
* [@subnixr](https://github.com/subnixr) for the beautiful Zsh theme.
* [Caneco](https://github.com/Caneco) for the awesome header design in this README.
* [Emma Fabre](https://github.com/emmafabre) for her informative Homebrew presentation.

And thanks to all the open-source contributors who share their dotfiles!

---

### Enjoy Your New macOS Setup!