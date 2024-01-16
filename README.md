Grafana Dashboard for Veeam Backup & Replication REST API
===================

![alt tag](https://jorgedelacruz.uk/wp-content/uploads/2023/05/grafana-veeam-api-001-1.jpg)

This project consists of a Docker Container which uses cron to run a Bash Shell script to retrieve the Veeam Backup & Replication information, directly from the RESTfulAPI, about last jobs, users and much more. The information is being saved it into InfluxDB output directly into the InfluxDB database using curl, then in Grafana: a Dashboard is created to present all the information.

We use Veeam Backup & Replication RESTfulAPI to reduce the workload and increase the speed of script execution. 

----------

### Configuration
The configuration is applied by applying environment variables to your Docker container as follows:

Required Variables:
- `INFLUX_URL` Your InfluxDB Server, http://FQDN or https://FQDN if using SSL
- `INFLUX_BUCKET` InfluxDB bucket name (not ID)
- `INFLUX_TOKEN` InfluxDB access token with read/write privileges for the bucket
- `INFLUX_ORG` InfluxDB organisation name (not ID)
- `VEEAM_USER` Veeam username
- `VEEAM_PASSWORD` Veeam password
- `VEEAM_ADDRESS` The IP address or host name of your Veeam server

Optional Variables:
- `INFLUX_PORT` Default Port 8086
- `VEEAM_PORT` Default Port 9419
- `VEEAM_JOBSESSIONS` Defaults to 1000

----------

### Getting started

* Deploy a container with the above environment variables set:
`docker run -e INFLUX_URL='http://FQDN' -e INFLUX_BUCKET='my_bucket'` ... etc ... `veeam_backup_and_replication_grafana:latest`
* Download the Veeam Backup & Replication JSON file and import it into your Grafana
* Enjoy :)

For more information see the original script author's Blog Post - https://jorgedelacruz.uk/2023/05/31/looking-for-the-perfect-dashboard-influxdb-telegraf-and-grafana-part-xliv-monitoring-veeam-backup-replication-api/
----------

### Additional Information
* Timing of running the script (default every 15mins) is controlled by the crontab file and can therefore only be changed by editing the crontab and rebuilding the container.
* The Dockerfile manually references the amd64 version of the influx CLI so this line must be changed to build a container image compatible with other architectures.

### Known issues 
Would love to see some known issues and keep opening and closing as soon as I have feedback from you guys. Fork this project, use it and please provide feedback.