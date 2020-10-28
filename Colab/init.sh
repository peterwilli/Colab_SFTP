#!/bin/sh
init()
{
    mkdir -p /content/ssh
    apt-get install -y sshfs
    if test -f "/root/.ssh/id_rsa"; then
        echo "Private key already exists, skip creation..."
    else
        cat /dev/zero | ssh-keygen -b 4096 -q -N ""
    fi

    cat > /usr/bin/mount_colab_sftp << "EOL"
sleep_seconds=5
umount /content/ssh > /dev/null 2>&1
until error=$(sshfs -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,UserKnownHostsFile=/dev/null,StrictHostKeyChecking=no root@$1:/root -p ${2:-2222} /content/ssh 2>&1 >/dev/null); do
    error_str="Error: $error.\nWill try again in $sleep_seconds seconds!"
    error_len=${#error_str}
    echo -e $error_str
    sleep $sleep_seconds
    printf '\b%.0s' $(seq 1 $error_len)
done
echo 'Mounted /content/ssh'
EOL
    chmod a+x /usr/bin/mount_colab_sftp
}
init > /dev/null 2>&1

echo "Run the authenticate file in the colab_sftp folder, and paste the key below!"
cat ~/.ssh/id_rsa.pub
