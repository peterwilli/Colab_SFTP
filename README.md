# Colab SFTP

When working with Google Colab, we're used to mounting Google Drive to persist any data.

However, as I noticed during my research, the storage quickly adds up and causes problems, there's nothing worse than having a trained model finished, only to find out the runtime restarted and the model didn't persist in Drive.

I didn't want to buy more storage, as I barely use Google Drive anyway, aside for it being a "gateway" where I download the model to my own computer and on top of that, you need to have your computer connected to Colab anyway if you want the runtime to run for longer, so why not use the connection to your PC you already have?!

This made me look for an alternative, where instead of mounting a folder on Google Drive, I could mount a folder that is synced locally with a folder on my own PC.

[This support link of Google](https://support.google.com/machinelearningeducation/thread/4522670?hl=en) shows that they clearly have no intent to fix this.

## Introducing Colab_SFTP

To answer this need, I came up with the following:

- Making it as easy as possible to mount a Colab folder to a local folder on your laptop using scripts.
- Using established tools and crypto, such as sftp and ssh
- Making it secure, running inside a Docker VM, no need to install any dependency, keeping your PC clean.

## How to get started

We assume that you have a Linux computer with Docker installed.
We also assume you can forward the SSH port `2222` to your local device, should you be on Wifi, or am capable of opening the port in your firewall, should you have any. For port forwarding, refer to [this guide](https://portforward.com/router.htm).

- Clone this repo.
- `cd` to the repo you just cloned.
- Run the first script: `./build`
- Run `./run` to start the SFTP server. A new directory called `data/` is made, this is where your files are synced.
- In your Colab notebook, make a code block and execute the following: `!sh -c "$(curl -fsSL https://raw.githubusercontent.com/peterwilli/Colab_SFTP/master/Colab/init.sh)"`
- After you're done, you get a key that you need to paste in your terminal on your PC to authenticate Colab.
    - Run `./authenticate` and paste the key.
- In Colab, make a new code block, and paste: `!mount_colab_sftp <your ip>`. You can find [your IP adress here](https://duckduckgo.com/?q=my+ip).

And you're done!