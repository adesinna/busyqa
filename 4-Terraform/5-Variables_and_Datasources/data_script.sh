#!/bin/bash

# Install Apache
apt update
apt install -y apache2

# Create index.html file with Hello, World! content
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Hello, World!</title>
</head>
<body>
    <h1>Hello, World!</h1>
    <p>Welcome to my Ubuntu web server.</p>
</body>
</html>
EOF

# Start Apache and enable it to start on boot
systemctl enable apache2
systemctl start apache2
