#!/bin/bash
#######################################
# Script Name: jenkinslogstos3.sh
# Author: Prathap Kumar
# Date: 2023-10-04
# Version: 1.1
# Description: This script uploads Jenkins logs of a specific job to an S3 bucket.
# Usage: ./jenkinslogstos3.sh
# Dependencies: awscli
##########################################################

# Function to upload Jenkins logs of a specific job to S3
upload_jenkins_job_logs() {
    echo "Uploading Jenkins job logs to S3..."
    # Replace with your S3 bucket name and Jenkins job log directory
    S3_BUCKET="s3://jenkingslogstos3"
    JENKINS_JOB_NAME="Demo" # Replace with your Jenkins job name
    JENKINS_LOG_DIR="/var/lib/jenkins/jobs/$JENKINS_JOB_NAME/builds"
    
    if [ ! -d "$JENKINS_LOG_DIR" ]; then
        echo "Jenkins job logs directory not found: $JENKINS_LOG_DIR"
        return 1
    fi

    # Upload logs to S3
    aws s3 cp "$JENKINS_LOG_DIR" "$S3_BUCKET/$JENKINS_JOB_NAME" --recursive
    if [ $? -eq 0 ]; then
        echo "Jenkins job logs uploaded successfully to S3."
        return 0
    else
        echo "Failed to upload Jenkins job logs to S3."
        return 1
    fi
}

# Function to send email notification
send_email_notification() {
    local status=$1
    echo "Sending email notification..."
    # Replace with your email details
    EMAIL_SUBJECT="Jenkins Logs Upload Status"
    if [ "$status" -eq 0 ]; then
        EMAIL_BODY="The Jenkins logs for the job have been uploaded to the S3 bucket successfully."
    else
        EMAIL_BODY="Failed to upload Jenkins logs for the job to the S3 bucket."
    fi
    EMAIL_TO="darla.832865@gmail.com"
    echo "$EMAIL_BODY" | mail -s "$EMAIL_SUBJECT" "$EMAIL_TO"
    if [ $? -eq 0 ]; then
        echo "Email notification sent successfully."
    else
        echo "Failed to send email notification."
    fi
}

# Main script execution
echo "Starting Jenkins logs upload script..."
upload_jenkins_job_logs
UPLOAD_STATUS=$?
send_email_notification $UPLOAD_STATUS
echo "Jenkins logs upload script completed."


# To add a cron job for this script to run every 1 hour:
# 1. Open the crontab file in the nano editor:
#    crontab -e
# 2. Add the following line to schedule the script:
#    0 * * * * /bin/bash /C:/Users/DELL/jenkinslogstos3.sh
# 3. Save and exit the editor.

# End of script

# Note: This script uploads Jenkins job logs to an S3 bucket and sends email notifications.
# Note: Ensure that the AWS CLI is configured with the necessary permissions to access the S3 bucket.
# Note: Ensure that the mail utility is installed and configured on the system to send email notifications.
# Note: Replace the S3 bucket name, Jenkins job name, and email details with your own.
# Note: This script is a basic example and can be extended to include more features as per your requirements.
# Note: This script is intended to be run as a cron job or manually as needed.
# Note: Ensure that the necessary permissions are set for the script to execute.
# Note: You may need to install the AWS CLI and mail utility if they are not already installed on your system.
# Note: This script is a basic example and can be extended to include more checks and notifications as per your requirements.
# Note: This script is intended to be run as a cron job or manually as needed.

