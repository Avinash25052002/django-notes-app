FROM python:3.9

# Set working directory
WORKDIR /app

# Copy requirements first (for cache)
COPY requirements.txt .

# System dependencies
RUN apt-get update \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Python dependencies
RUN pip install --no-cache-dir mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy full project
COPY . .

# Expose Django port
EXPOSE 8000

# Run migrations + start server (IMPORTANT)
CMD ["sh", "-c", "python3 manage.py migrate && python3 manage.py runserver 0.0.0.0:8000"]
