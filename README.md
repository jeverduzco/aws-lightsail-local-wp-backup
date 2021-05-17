## Simple bash script to create AWS Lightsail WordPress backups

This script is used to automate local WordPress backups on an AWS Lightsail instance.

## How to use it

1. Connect to your WordPress instance over SSH

2. Create a file and assign it the correct permissions
   ```sh
   sudo touch backup.sh && sudo chmod u+x backup.sh && sudo chmod 744 backup.sh
   ```
3. Edit the file and: copy and paste the script you need
   ```sh
   sudo nano backup.sh
   ```
4. Execute the script
   ```sh
   sudo bash backup.sh
   ```
This will create a copy of your WordPress and your database in:
```sh
/var/backups/wordpress
```
And that's it

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.