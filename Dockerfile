FROM ubuntu:16.04
MAINTAINER dannytech <dannytech@users.noreply.github.com>

# Install dependencies
RUN apt-get update
RUN apt-get install -y wget python unzip software-properties-common openjdk-8-jdk g++-4.9 cmake libprotobuf-dev libprotoc-dev protobuf-compiler
RUN ln -s /usr/bin/g++-4.9 /usr/bin/g++

# Install Gazebo
RUN echo "deb http://packages.osrfoundation.org/gazebo/ubuntu xenial main" > /etc/apt/sources.list.d/gazebo-latest.list
RUN wget --quiet http://packages.osrfoundation.org/gazebo.key -O - | apt-key add -
RUN apt-get update
RUN apt-get install -y gazebo8 libgazebo8-dev

# Download WPILib plugins and samples
RUN wget -O ~/plugins_and_samples.zip http://first.wpi.edu/FRC/roborio/maven/release/edu/wpi/first/wpilib/simulation/simulation/2017.3.1/simulation-2017.3.1.zip
RUN mkdir -p ~/wpilib/simulation/gz_msgs/build
RUN unzip ~/plugins_and_samples.zip -d ~/wpilib/simulation
RUN rm ~/plugins_and_samples.zip

# Build gz_msgs
RUN cd ~/wpilib/simulation/gz_msgs/build
RUN cmake ..
RUN make install

ENTRYPOINT []
