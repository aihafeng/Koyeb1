server {
    listen 80;
    listen [::]:80;

    server_name _;

    location / {
        root /usr/share/nginx/html;
        index index.html;
    }

    location /vmess {
        proxy_pass http://127.0.0.1:10000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
    }

    location /sub {
        default_type text/plain;
        return 200 "dm1lc3M6Ly9leUoySWpvaU1pSXNJbkJ6SWpvaVlYQndiSGtnWW5WcGJHUXZkbTBpTENKaFpHUWlPaUptWlc1bloxQXVZWEJ3YkhrdVluVnBiR1FpTENKd2IzSjBJam9pT0RBaUxDSnBaQ0k2SWpkaE5XSTVZamRrTFRWbU1qa3ROR0UzTWkxaFkyYzVMV1F4T1dFeU1tWmlZVFl6TkRRaUxDSmhhV1FpT2lJd0lpd2ljMk41SWpvaVlYVjBiMElpTENKdVpYUWlPaUp6SWl3aWRIbHdaU0k2SW01dmJtVWlMQ0pvYjNOMElqb2labVZ1WjJjdVlYQndiSGt1WW5WcGJHUXVZWEJ3YkhrdVluVnBiR1FpTENKd1lYUm9Jam9pTDNadFpYTnpJaXdpZEhSeklqb2lJaXdpYzI1cElqb2lJaXdpWVd4d2JpSTZJaUlzSW1sdWMyVmpkWEpsSWpvaU1DSjk=";
    }
}
