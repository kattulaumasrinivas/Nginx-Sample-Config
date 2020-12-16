worker_processes  5;
events {
 worker_connections  4096;
}

http {
 server_tokens off;
 client_max_body_size 7G;
 server {
       listen              443 ssl;
       server_name         uma.srinivaskattula.com;
       ssl                 on;
       ssl_certificate     tls.crt;
       ssl_certificate_key tls.key;
       ssl_protocols       TLSv1.2 TLSv1.3;
       add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
       add_header X-XSS-Protection "1; mode=block";

   location / {
     proxy_pass      http://localhost:4000;
   }
   location /v1/chatbot {
     proxy_pass     http://localhost:8101;
   }
   location /v2/chatbot {
     proxy_pass     http://localhost:8101;
   }
   location /strapi/web/ {
     proxy_pass http://localhost:1337;
   }
   location /strapi/ {
     proxy_pass http://localhost:1337/;
   }
   location /trainer/ {
     proxy_pass  http://localhost:8002/;
   }
   location /modeler/ {
     proxy_pass  http://localhost:9013/;
   }
   location /parse {
     proxy_pass  http://localhost:5000;
   }
   location /chm/ {
     proxy_set_header Upgrade $http_upgrade;
     proxy_set_header Connection "upgrade";
     proxy_http_version 1.1;
     proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
     proxy_set_header Host $host;
     proxy_pass   http://localhost:3030/;
   }
   #admin portal
   location /org {
     proxy_pass     http://localhost:8080/org ;
   }
   location /org-welcome {
     proxy_pass     http://localhost:8080/org-welcome ;
   }
   location  /trainerapi/ {
     proxy_set_header Upgrade $http_upgrade;
     proxy_set_header Connection "upgrade";
     proxy_http_version 1.1;
     proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
     proxy_set_header Host $host;
     proxy_pass   http://localhost:3000/;
   }
 }
}
