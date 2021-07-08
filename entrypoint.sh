#!/bin/bash
set -Ceux

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

# Add local normal user and set to sudo
USER_ID=${LOCAL_UID:-1000}
GROUP_ID=${LOCAL_GID:-1000}
USER_NAME=user
GROUP_NAME=user
PASSWORD=0000

echo "Starting with UID : $USER_ID($USER_NAME), GID: $GROUP_ID($GROUP_NAME)"
set +e
groupadd -g $GROUP_ID $GROUP_NAME
useradd -m -s /bin/bash -u $USER_ID -g $GROUP_ID -G sudo $USER_NAME
usermod -u $USER_ID -g $GROUP_ID $USER_NAME
echo $USER_NAME:$PASSWORD | chpasswd
echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
set -e
export HOME=/home/$USER_NAME

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec /usr/sbin/gosu $USER_NAME "$@"