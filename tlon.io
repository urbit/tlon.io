server {
        listen 443;
	server_name tlon.io www.tlon.io;

	access_log /var/log/nginx/tlon.io.log;

  ssl on;
  ssl_certificate /etc/letsencrypt/live/tlon.io/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/tlon.io/privkey.pem;

  ssl_session_timeout 5m;

  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;

  root /home/urb/github/keatondunsford/tlon.io/dist;
}

server {
  listen 80;
  server_name tlon.io www.tlon.io;

  access_log /var/log/nginx/tlon.io.log;

  return 301 https://$host$request_uri;
}
