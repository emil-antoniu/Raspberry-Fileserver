# Raspberry Fileserver

<p>This constitutes a home project for file sharing on a local network, as well as on wide area networks via a peer-to-peer sharing client.</p>

<p>The fileserver is a Raspberry Pi Model 3 A+ provisioned with a 0.96 Inch I2C/IIC 4-Pin OLED Display Module running Raspberry OS 64-bit Lite.</p>

<p>Configurations are made with a non-default admin user in mind. Connections are done via SSH with public-key authentication only.</p>

<p>The main software components used are:</p>

<ul>
  <li><b>qBittorrent-nox</b> as the peer-to-peer client.</li>
  <li><b>ufw</b> as the firewall.</li>
  <li><b>expressvpnctl</b> as the managed VPN service.</li>
  <li><b>Samba</b> for LAN file-sharing.</li>
  <li>Other miscellaneous tools for troubleshooting.</li>
</ul>
