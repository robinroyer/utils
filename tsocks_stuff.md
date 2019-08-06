```sh
#!/bin/zsh

echo "you are : $(whoami)"

if [[ "$UID" -ne 0 ]]; then exec sudo "$0" "$@";fi

echo "killing old connection on 8079"
ps aux | grep "ssh -f -N -D 8079 robin" | grep -v "grep" | awk '{print $2}' | xargs -I % sh -c 'echo "killing %" && kill %'
echo "open new ssh connection to server"
ssh -f -N -D 8079 robin > /dev/null 2>&1

echo "create conf /etc/socks"

sudo -k
echo -e "\nserver = 127.0.0.1\nserver_port = 8079" > /etc/tsocks.conf

echo "your configuration file is /etc/tsocks.conf"
echo "your ip is $(curl -s ifconfig.co)"
echo "your socks server's ip is $(tsocks curl -s ifconfig.co)"
echo "Prefix command with tsocks to get your traffic through your ssh tunnel"
echo "copy /etc/tsocks.conf to ~/.tsocks.conf to automaticly use the tunnel without prefix"
```

then:
`tsocks curl google.com`
or for sandbox app
`chromium-browser --proxy-server=socks5://127.0.0.1:8079`
