
## wireguard with UI
```bash

docker run --name vpn --restart  always -d  -v /etc/wireguard/:/data -p 127.0.0.1:8080:8080 -e "WG_CONF_DIR=/data" vx3r/wg-gen-web:latest
```

### with smtp
```bash

docker run --name vpn --restart  always -d  -v /etc/wireguard/:/data -p 127.0.0.1:8080:8080 --env-file=./wgenv.txt vx3r/wg-gen-web:latest
```

### instal wireguard on host
```bash
sudo apt install wireguard
sudo systemctl start wg-quick@wg0
sudo systemctl status wg-quick@wg0
sudo systemctl restart wg-quick@wg0
```
### wg0.conf
```
PreUp = echo WireGuard PreUp
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o ens5 -j MASQUERADE;
PreDown = echo WireGuard PreDown
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o ens5 -j MASQUERADE;
```
