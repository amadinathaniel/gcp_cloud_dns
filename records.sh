#!/bin/bash

# List all projects in your organization
echo "Getting list of projects..."
gcloud projects list

# Get ID of project 1 
echo -n "Enter the project ID of the first project: "
read project_id
sleep 2

# Get the DNS managed zone:
echo "Listing tbe managed zone in the $project_id"
gcloud dns managed-zones list --project=$project_id
sleep 2

echo -n "Kindly specify the zone name in which you want to export the records: "
read zone_name
echo "Exporting the DNS records sets in $project_id with the zone name: $zone_name"
gcloud dns record-sets list --zone=$zone_name --project=$project_id --format=json > records.json
echo "#################################################################################"
echo "Kindy copy out the content of records.json file and use in the tfvars file or variables.tf"