
🛡️ XUI Google Drive Backup Installer
=====================================

پروژه‌ای قدرتمند برای بکاپ‌گیری اتوماتیک از پنل XUI و آپلود مستقیم در Google Drive
طراحی شده توسط Mr.Ali 👨‍💻

🚀 ویژگی‌ها
----------
✅ بکاپ‌گیری روزانه از /etc/x-ui/

✅ فشرده‌سازی و آپلود مستقیم در Google Drive

✅ سیستم نصب و حذف اتوماتیک

✅ اجرای کاملاً بدون دخالت بعد از گرفتن یک‌بار تأییدیه

✅ ذخیره لاگ اجرای روزانه در
/var/log/xui_gdrive_backup.log

🔐 مرحله 1: ساخت فایل credentials.json
-----------------------------------------
1. وارد Google Cloud Console شو:
   https://console.cloud.google.com

2. یک پروژه جدید بساز (مثلاً: xui-backup)

3. برو به:
   APIs & Services > Library
   سرچ کن: Drive API → Enable کن

4. برو به:
   OAuth consent screen → User Type: External → Next
   - App name: XUI Backup
   - Support email و Developer email: ایمیل خودت
   - در مرحله آخر، در بخش Test Users ایمیل خودتو وارد کن
   - Save

5. برو به:
   Credentials > Create Credentials > OAuth client ID
   - Application Type: Desktop App
   - Name: xui-uploader
   - روی Create بزن → فایل credentials.json رو دانلود کن ✅

💾 مرحله 2: آپلود فایل credentials.json روی سرور
-------------------------------------------------
با استفاده از scp یا WinSCP:

scp credentials.json root@your-server:/root/gdrive-backup/

⚙️ مرحله 3: نصب خودکار پروژه
------------------------------
1. دریافت فایل ZIP:

   [دانلود فایل زیپ پروژه] یا:

   git clone https://github.com/yourusername/xui-gdrive-backup.git
   cd xui-gdrive-backup
   chmod +x install.sh
   ./install.sh

🧩 منوی نصب ظاهر می‌شود:
--------------------------
===============================
  XUI Backup System
  Developed by Mr.Ali
===============================
1) Install
2) Uninstall
3) Exit

- گزینه 1 را بزن
- اگر فایل credentials.json وجود داشته باشد، فرایند نصب آغاز می‌شود
- لینک تأیید گوگل نمایش داده می‌شود
- وارد مرورگر شو، Gmail رو تایید کن، کد بده → پایان!

🕒 اجرای خودکار بکاپ
----------------------
پس از نصب، بکاپ به‌صورت روزانه در ساعت 3:00 صبح انجام می‌شود و در گوگل درایو ذخیره خواهد شد.

🧹 حذف کامل (Uninstall)
--------------------------
در همان منوی نصب، گزینه 2) Uninstall را انتخاب کن.

📁 ساختار بکاپ
---------------
بکاپ‌ها با فرمت .tar.gz و نام‌هایی مثل زیر ذخیره می‌شوند:

xui-backup-2025-07-22-03-00.tar.gz

شامل فایل‌های تنظیمات و دیتابیس پنل x-ui

🛡 نکات امنیتی
---------------
- credentials.json را فقط برای همین سرور استفاده کن
- فایل‌های بکاپ شامل اطلاعات حساس هستند – رمزنگاری در صورت نیاز پیشنهاد می‌شود

🧠 توسعه‌دهنده
----------------
Developed with ❤️ by Mr.Ali
