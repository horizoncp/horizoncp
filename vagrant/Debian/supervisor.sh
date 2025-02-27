# Configure Supervisor
echo "Configuring Supervisor for queue workers..."
cat <<EOF | sudo tee /etc/supervisor/conf.d/horizoncp_worker.conf
[program:horizoncp-worker]
process_name=%(program_name)s_%(process_num)02d
command=php /var/www/web/artisan queue:work --tries=3
autostart=true
autorestart=true
numprocs=1
redirect_stderr=true
stdout_logfile=/var/log/horizoncp_worker.log
EOF
sudo systemctl restart supervisor
