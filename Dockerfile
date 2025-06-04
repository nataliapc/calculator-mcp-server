# Use Python 3.11 slim image as base
FROM python:3.11-slim

# Set working directory
WORKDIR /mcp-server

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bash \
        && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better Docker layer caching
COPY requirements.txt .
# Copy application files
COPY calculator_server.py .
COPY run_calculator_server.sh .
COPY setup_venv.sh .

# Make shell scripts executable
RUN chmod +x run_calculator_server.sh setup_venv.sh

# Install Python dependencies and set up virtual environment
RUN bash setup_venv.sh

# Expose the default MCP port (if needed for network access)
# Note: MCP servers typically run via stdio, but exposing for flexibility
#EXPOSE 3000

# Set the default command to run the calculator server
CMD ["bash", "run_calculator_server.sh"]