# # FROM   centos as builder
# # RUN   yum install python 
# # COPY  . . 


# # #final stage 
# # FROM python 
# # COPY --from=builder 
# # CMD [python hello.p]

# FROM ubuntu:latest

# # Set the working directory in the image
# WORKDIR /app

# # Copy the files from the host file system to the image file system
# COPY . /app

# # Install the necessary packages
# RUN apt-get update && apt-get install -y python3 python3-pip

# # Set environment variables
# ENV NAME World

# # Run a command to start the application
# CMD ["python3", "app.py"]



# Use the official Ubuntu base image
FROM ubuntu:latest

# Set the maintainer label
LABEL maintainer="yourname@example.com"

# Update the package list and install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    iputils-ping \
    net-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the default command to an interactive shell
CMD ["bash"]
