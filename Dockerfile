# Base image
FROM python:3.9

# Set working directory where manage.py exists
WORKDIR /app

# Copy only requirements first (for caching)
COPY requirements.txt .

# Install system dependencies
RUN apt-get update \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire project
COPY . .

# Expose port for Django
EXPOSE 8000

# Optional: run migrations before starting server
# CMD ["sh", "-c", "python3 manage.py migrate && python3 manage.py runserver 0.0.0.0:8000"]

# Start Django development server
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]




