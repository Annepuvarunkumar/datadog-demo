#!/bin/bash

# Function to check the exit status of the last command
func_exit_status() {
  if [ $? -eq 0 ]; then
    echo -e "\e[32m SUCCESS \e[0m"
  else
    echo -e "\e[31m FAILURE \e[0m"
    exit 1
  fi
}

# Component variable (for consistency in messages)
component="Datadog Agent Setup"

# Step 1: Update the system packages
echo -e "\e[36m>>>>>>>>>>>>>>> Updating system packages <<<<<<<<<<<<<<<\e[0m"
sudo yum update -y
func_exit_status

# Step 2: Install necessary dependencies (curl and sudo)
echo -e "\e[36m>>>>>>>>>>>>>>> Installing dependencies (curl and sudo) <<<<<<<<<<<<<<<\e[0m"
sudo yum install -y curl sudo
func_exit_status

# Step 3: Install the Datadog Agent
echo -e "\e[36m>>>>>>>>>>>>>>> Installing ${component} <<<<<<<<<<<<<<<\e[0m"
DD_API_KEY="97a8b96aea97b57a865936aea9c8a187"  # Datadog API key
DD_SITE="datadoghq.com"  # Datadog site URL
bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"
func_exit_status

# Step 4: Start the Datadog Agent service
echo -e "\e[36m>>>>>>>>>>>>>>> Starting ${component} service <<<<<<<<<<<<<<<\e[0m"
sudo systemctl start datadog-agent
func_exit_status

# Step 5: Enable the Datadog Agent to start automatically on boot
echo -e "\e[36m>>>>>>>>>>>>>>> Enabling ${component} to start on boot <<<<<<<<<<<<<<<\e[0m"
sudo systemctl enable datadog-agent
func_exit_status

# Step 6: Verify the status of the Datadog Agent service
echo -e "\e[36m>>>>>>>>>>>>>>> Verifying ${component} status <<<<<<<<<<<<<<<\e[0m"
sudo systemctl status datadog-agent | grep "Active"
func_exit_status

# Step 7: Allow a brief wait time for the agent to start collecting metrics
echo -e "\e[36m>>>>>>>>>>>>>>> Waiting for ${component} to start collecting metrics <<<<<<<<<<<<<<<\e[0m"
sleep 30  # Wait for 30 seconds
func_exit_status

# Final Success Message
echo -e "\e[32m Datadog Agent is now running successfully! \e[0m"
echo -e "\e[36m You can monitor your EC2 instance metrics on the Datadog dashboard: https://app.datadoghq.com \e[0m"
