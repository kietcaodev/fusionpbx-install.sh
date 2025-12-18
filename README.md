
FusionPBX Install
--------------------------------------
A streamlined installation script for installing FusionPBX on Debian-based systems. This script automates the setup of FusionPBX along with FreeSWITCH, PostgreSQL, Nginx, PHP, and other required components.

## Requirements

- Fresh installation of Debian 11 (Bullseye) or Debian 12 (Bookworm)
- Minimal server installation recommended
- Root access or sudo privileges
- Internet connection

## Supported Operating System

### Debian 11/12 and Raspberry Pi OS

Debian is the preferred and officially supported operating system. It provides stable packages and excellent compatibility with FreeSWITCH and FusionPBX.

**Quick Install:**

```sh
wget -O - https://raw.githubusercontent.com/kietcaodev/fusionpbx-install.sh/master/debian/pre-install.sh | sh;
cd /usr/src/fusionpbx-install.sh/debian && ./install.sh
```


## What Gets Installed

The installation script will set up:

- **FreeSWITCH** - Open source telephony platform
- **FusionPBX** - Web-based GUI for FreeSWITCH
- **PostgreSQL** - Database server
- **Nginx** - Web server
- **PHP-FPM** - PHP processor
- **Fail2ban** - Intrusion prevention system
- **Monit** - Process monitoring
- **Let's Encrypt** - SSL/TLS certificates (optional)

## Post-Installation

After installation completes:

1. Open your web browser and navigate to your server's IP address or domain name
2. Complete the FusionPBX web-based setup wizard
3. Login with the default credentials provided during installation
4. **Important:** Change the default passwords immediately

## Security Considerations

### Fail2ban
Fail2ban is installed and pre-configured to protect against brute-force attacks. The default configuration includes:

- SSH protection
- FreeSWITCH SIP protection
- Nginx web server protection
- FusionPBX login protection

Configuration file: `/etc/fail2ban/jail.local`

**Recommended actions:**
- Review and adjust ban times based on your security requirements
- Configure email notifications for security alerts
- Regularly review ban logs: `fail2ban-client status`

### Firewall
The script configures iptables or nftables with the following open ports:
- 22 (SSH)
- 80 (HTTP)
- 443 (HTTPS)
- 5060-5061 (SIP)
- 5080-5081 (SIP)
- 16384-32768 (RTP Media)

### Best Practices
1. Change all default passwords immediately after installation
2. Enable two-factor authentication in FusionPBX
3. Keep your system updated: `apt update && apt upgrade`
4. Regularly backup your system and database
5. Use strong passwords for all accounts
6. Consider implementing IP whitelisting for admin access

## Troubleshooting

### Check Service Status
```sh
systemctl status freeswitch
systemctl status postgresql
systemctl status nginx
systemctl status php*-fpm
```

### View Logs
```sh
# FreeSWITCH logs
tail -f /var/log/freeswitch/freeswitch.log

# Nginx logs
tail -f /var/log/nginx/error.log

# System logs
journalctl -xe
```

### Common Issues

**FreeSWITCH won't start:**
```sh
systemctl restart freeswitch
journalctl -u freeswitch -n 50
```

**Database connection issues:**
```sh
systemctl restart postgresql
```

**Web interface not loading:**
```sh
systemctl restart nginx
systemctl restart php*-fpm
```

## Backup

The installation includes backup scripts in `/usr/local/bin/`:
- `fusionpbx-backup` - Full system backup
- `fusionpbx-maintenance` - Database maintenance

Schedule regular backups with cron:
```sh
crontab -e
# Add: 0 2 * * * /usr/local/bin/fusionpbx-backup
```

## Support & Documentation

- **Official FusionPBX Documentation:** https://docs.fusionpbx.com
- **FreeSWITCH Documentation:** https://freeswitch.org/confluence/
- **Community Forum:** https://www.fusionpbx.com

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

This project follows the same license as FusionPBX.

## Disclaimer

This script is provided as-is without any warranty. Always test in a non-production environment first. Review and understand what the script does before running it on your system.
