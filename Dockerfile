# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install pytest if it's not included in the requirements.txt
RUN pip install pytest

# Make port 8080 available to the world outside this container (if your app needs it)
EXPOSE 8080

# Run the application or tests
# Change this based on whether you're running your app or tests
# CMD ["python", "square_root_calculator.py"]  # To run the app (replace with actual file)
CMD ["pytest"]  # To run pytest for testing
