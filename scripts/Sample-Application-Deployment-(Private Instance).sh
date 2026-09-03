# index.html file create karein
cat <<EOF > index.html
<!DOCTYPE html>
<html>
<body>
<h1>My First AWS Project</h1>
<p>To demonstrate apps in private subnet</p>
</body>
</html>
EOF

# Python web server port 8000 par run karein
python3 -m http.server 8000
