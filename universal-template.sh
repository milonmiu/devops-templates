--- [ TEMPLATE 1: UNIVERSAL BASH SCRIPT (universal-template.sh) ] ---
#!/bin/bash
set -e  # কোনো কমান্ড ব্যর্থ হলে সাথে সাথে স্ক্রিপ্ট থেমে যাবে

# ১. ভ্যারিয়েবল ডিক্লেয়ারেশন (= চিহ্নের আগে-পরে কোনো স্পেস দেওয়া যাবে না)
APP_NAME="my-devops-app"
TARGET_HOST="127.0.0.1"

# ২. ফাংশন (নিচে log_info "..." লিখে কল করলে টেক্সটটি $1-এর জায়গায় বসে প্রিন্ট হবে)
log_info() {
    echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# ৩. কানেক্টিভিটি চেক ($? মানে ঠিক আগের কমান্ডের রেজাল্ট: 0 = সফল, অন্য সংখ্যা = ব্যর্থ)
log_info "Checking connectivity for $APP_NAME on $TARGET_HOST..."
ping -c1 $TARGET_HOST &> /dev/null   # &> /dev/null দিয়ে পিংয়ের আউটপুট লুকানো হয়েছে

if [ $? -eq 0 ]; then
    log_info "$TARGET_HOST is UP! Starting deployment..."
else
    echo "[ERROR] $TARGET_HOST is DOWN!"
    exit 1  # exit 1 মানে এরর সিগন্যাল দিয়ে স্ক্রিপ্ট এখানেই বন্ধ করে দেওয়া
fi          # fi দিয়ে if শর্ত শেষ করা হলো

# ৪. ফর লুপ (তালিকার ৩টি কাজ একে একে $step ভ্যারিয়েবলে নিয়ে প্রিন্ট করবে)
for step in "Update-Cache" "Install-Packages" "Start-Service"; do
    log_info "Executing: $step"
done

