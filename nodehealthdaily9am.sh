#!/bin/bash
#################################################
# Script Name: AT_9AM_To Check the haelth and infra.sh
#author:  Prathap Kumar
# Date: 2023-10-04
#Version: 1.0
# Description: This script is used to check the health of the system and infrastructure.
# Usage: ./AT_9AM_To_Check_the_haelth_and_infra.sh
# Dependencies: curl, jq
# Notes: This script is intended to be run as a cron job at 9 AM every day.
# Example cron job entry: 0 9 * * * /path/to/AT_9AM_To_Check_the_haelth_and_infra.sh
#################################################

# Function to check system health
check_system_health() {
    echo "Checking system health..."
    # Check CPU usage
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo "CPU Usage: $cpu_usage%"

    # Check memory usage
    mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    echo "Memory Usage: $mem_usage%"

    # Check disk usage
    disk_usage=$(df -h | grep '^/dev/' | awk '{ print $5 }' | sed 's/%//g' | sort -n | tail -n 1)
    echo "Disk Usage: $disk_usage%"
}

# Function to check infrastructure health
check_infra_health() {
    echo "Checking infrastructure health..."
    # Check if the web server is running
    web_server_status=$(systemctl is-active apache2)
    if [ "$web_server_status" == "active" ]; then
        echo "Web Server Status: Running"
    else
        echo "Web Server Status: Not Running"
    fi

    # Check if the database server is running
    db_server_status=$(systemctl is-active mysql)
    if [ "$db_server_status" == "active" ]; then
        echo "Database Server Status: Running"
    else
        echo "Database Server Status: Not Running"
    fi
}

# Function to send notification via Email
send_notification_email() {
    echo "Sending email notification..."
    # Replace with your email details
    echo -e "Subject: Health Check Report\n\nSystem Health:\n$(check_system_health)\n\nInfrastructure Health:\n$(check_infra_health)" | sendmail -v your-darla.832865@gmail.com
}

# Main script execution
echo "Starting health check script..."
check_system_health
check_infra_health
send_notification_slack  # or use send_notification_email for email notifications
echo "Health check script completed."
# End of script

# Note: This script checks the CPU, memory, and disk usage of the system.
# Note: This script is intended to be run as a cron job at 9 AM every day.
# Note: Ensure that the necessary permissions are set for the script to execute.
# Note: You may need to install curl and jq if they are not already installed on your system.
# Note: This script is a basic example and can be extended to include more checks and notifications as per your requirements.
# Note: Always test the script in a safe environment before deploying it to production.
# Note: Ensure that the script has execute permissions. You can set this using the command: chmod +x AT_9AM_To_Check_the_haelth_and_infra.sh

# Note: You can add logging functionality to log the output of the script to a file for future reference.
# Note: You can also add error handling to manage any unexpected issues that may arise during the execution of the script.
# Note: This script is a basic template and can be customized further based on your specific requirements.
# Note: Always keep your scripts updated and review them periodically to ensure they meet your current needs.
