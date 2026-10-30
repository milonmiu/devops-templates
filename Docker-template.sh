--- [ TEMPLATE 2: UNIVERSAL DOCKERFILE (Dockerfile) ] ---
# ১. হালকা বেস ইমেজ নির্বাচন
FROM python:3.9-slim

# ২. কন্টেইনারের ভেতরে ল্যান্ড করার মূল ফোল্ডার
WORKDIR /app

# ৩. কন্টেইনারের ভেতরের ফিক্সড এনভায়রনমেন্ট ভ্যারিয়েবল
ENV APP_PORT=5000 \
    PYTHONUNBUFFERED=1

# ৪. লেয়ার ক্যাশিং দ্রুত করতে সোর্স কোডের আগেই শুধু requirements.txt কপি ও ইনস্টল করা
# ('&&' মানে আগের কমান্ড সফল হলে পরেরটি চালাও; '\' মানে লম্বা লাইন ভেঙে নিচে লেখা)
COPY requirements.txt .
RUN apt-get update && apt-get install -y --no-install-recommends curl \
    && pip install --no-cache-dir -r requirements.txt \
    && rm -rf /var/lib/apt/lists/*

# ৫. অ্যাপের সব ফাইল কপি (প্রথম ডট = হোস্টের বর্তমান ফোল্ডার, দ্বিতীয় ডট = কন্টেইনারের /app ফোল্ডার)
COPY . .

# ৬. কন্টেইনারের ভেতরের লিসেনিং পোর্ট ডকুমেন্ট করা
EXPOSE 5000

# ৭. কন্টেইনারকে জীবিত রাখার ফোরগ্রাউন্ড স্টার্ট কমান্ড
CMD ["python", "app.py"]
