sudo useradd -m ip_phone -p $(python -c "import crypt, getpass, pwd; print crypt.crypt('Password','\$6\$SALTsalt\$')")
