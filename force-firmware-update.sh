#!/bin/bash

echo "=== Force Firmware Reinstall ==="
echo ""

# Stop fwupd
sudo systemctl stop fwupd

# Clear cache
echo "Clearing cache..."
sudo rm -rf /var/cache/fwupd/*
sudo rm -rf /var/lib/fwupd/*

# Restart fwupd
sudo systemctl start fwupd
sleep 2

# Enable all remotes
echo "Enabling all remotes..."
sudo fwupdmgr enable-remote lvfs
sudo fwupdmgr enable-remote lvfs-testing

# Force refresh
echo "Refreshing firmware database..."
sudo fwupdmgr refresh --force

# Show available updates
echo ""
echo "Available updates:"
fwupdmgr get-updates

# Update everything with force
echo ""
echo "Force updating all firmware..."
sudo fwupdmgr update --force

# Show history
echo ""
echo "Update history:"
fwupdmgr get-history

echo ""
echo "=== Complete! Please reboot. ==="
