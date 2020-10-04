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
    echo "sshfs -C -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@\$1:/root -p \${2:-2222} /content/ssh\necho 'Mounted /content/ssh'" > /usr/bin/mount_colab_sftp
    chmod a+x /usr/bin/mount_colab_sftp
    chmod a+x /usr/bin/unmount_colab_sftp
}
init > /dev/null 2>&1

echo "Run the authenticate file in the colab_sftp folder, and paste the key below!"
cat ~/.ssh/id_rsa.pub
