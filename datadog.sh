#!/bin/bash

# Set your Datadog API key and site URL
DD_API_KEY="97a8b96aea97b57a865936aea9c8a187"  # Datadog API key
DD_SITE="datadoghq.com"  # Datadog site URL

# Step 1: Update the system packages
echo "Updating system packages..."
sudo yum update -y

# Step 2: Install necessary dependencies (curl and sudo)
echo "Installing dependencies..."
sudo yum install -y curl sudo

# Step 3: Install the Datadog Agent
echo "Installing Datadog Agent..."
DD_API_KEY=$DD_API_KEY DD_SITE=$DD_SITE bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"

# Step 4: Start the Datadog Agent service
echo "Starting the Datadog Agent..."
sudo systemctl start datadog-agent

# Step 5: Enable the Datadog Agent to start automatically on boot
echo "Enabling Datadog Agent to start on boot..."
sudo systemctl enable datadog-agent

# Step 6: Verify the status of the Datadog Agent service
echo "Verifying the Datadog Agent status..."
sudo systemctl status datadog-agent | grep "Active"

# Step 7: Allow a brief wait time for the agent to start collecting metrics
echo "Waiting for Datadog Agent to start collecting metrics..."
sleep 30  # Wait for 30 seconds to allow the agent to collect system metrics

# Step 8: Inform the user that the agent is running and metrics will be visible on Datadog
echo "Datadog Agent is now running! You can monitor your EC2 instance's CPU, memory, disk usage, and network metrics."
echo "Go to your Datadog dashboard (https://app.datadoghq.com) to see the metrics for your EC2 instance."

# End of script
