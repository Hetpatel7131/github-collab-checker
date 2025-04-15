#!/bin/bash

# ------------------------------------------------------------
# Script Name: list-users.sh
# Author: Het Patel
# Date: April 14, 2025
# Description:
#   This script lists users who have read access (pull permission)
#   to a given GitHub repository. It uses GitHub's API and requires
#   a username and personal access token to be exported as environment
#   variables: USERNAME and TOKEN.
# ------------------------------------------------------------

# GitHub API base URL
API_URL="https://api.github.com"

# GitHub username and personal access token (ensure these are exported in your shell)
USERNAME=$username
TOKEN=$token

# Repository owner and name passed as arguments
REPO_OWNER=$1
REPO_NAME=$2

# Function to make an authenticated GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"
    curl -s -H "Authorization: token ${TOKEN}" -H "Cache-Control: no-cache" "$url"
}

# Function to list users with read access (pull permission) to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Get response from GitHub API
    response=$(github_api_get "$endpoint")

    # Check if response is a JSON array (valid list of collaborators)
    if echo "$response" | jq -e 'type == "array"' > /dev/null 2>&1; then
        collaborators=$(echo "$response" | jq -r '.[] | select(.permissions.pull == true) | .login')

        if [[ -z "$collaborators" ]]; then
            echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
        else
            echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
            echo "$collaborators"
        fi
    else
        # If not an array, it's likely an error message from the API
        echo "❌ Error fetching collaborators for ${REPO_OWNER}/${REPO_NAME}:"
        echo "$response" | jq -r '.message // "Unknown error."'
    fi
}

# Entry point
if [[ -z "$REPO_OWNER" || -z "$REPO_NAME" ]]; then
    echo "Usage: $0 <repo_owner> <repo_name>"
    exit 1
fi

echo "🔍 Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
