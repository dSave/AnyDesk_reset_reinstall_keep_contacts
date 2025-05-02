# AnyDesk Reset & Reinstall Script with Contact Restore

> A batch utility to automatically remove and reinstall AnyDesk while optionally preserving your configuration and contact list (`user.conf`).

📄 Русскую версию этого файла см. [README.ru.md](https://github.com/dSave/AnyDesk_reset_reinstall_keep_contacts/blob/main/README.ru.md)

---
---

## 🌐 Language Support

This script includes full bilingual output. When launched, it will prompt you to choose English or Russian.

## 🧩 Purpose

This script allows you to:

- Completely remove all components and traces of AnyDesk
- Backup the `user.conf` file (with settings and saved contacts)
- Reinstall AnyDesk from a previously downloaded installer
- Restore your configuration after reinstallation
- Or just completely uninstall AnyDesk without reinstalling

---

## ⚙️ How to Use

1. **Download the AnyDesk installer** from the official website:
   [https://anydesk.com/en/downloads](https://anydesk.com/en/downloads)

2. Place the `.exe` file into your `Downloads` folder

3. Run `AnyDesk_reset_reinstall_keep_contacts.bat` as **Administrator**

4. Follow the prompts:
   - Whether to back up your settings
   - Whether to reinstall or just uninstall

---

## 🔐 Administrator Rights Required

The script stops services, terminates processes, and deletes system directories. Therefore, **admin privileges are required**.

---

## 📁 Directories Removed

- `C:\ProgramData\AnyDesk`
- `%APPDATA%\AnyDesk`
- `%LOCALAPPDATA%\AnyDesk`
- `%ProgramFiles(x86)%\AnyDesk`

---

## 📦 System Requirements

- Windows 10 / 11 (or compatible)
- Ability to run scripts as Administrator

---

## 📜 License

GNU General Public License v3.0

You may freely use, modify, and distribute this script under the condition that the license is retained and modifications remain open-source.

---

## ✍️ Author

**dSave.ru** — Technical blog offering scripts and automation for admins and users.

🔗 [https://dSave.ru](https://dSave.ru)

---
