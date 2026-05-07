#!/bin/bash
cat <<EOF | sudo tee /etc/systemd/system/mlops-serve.service > /dev/null
[Unit]
Description=MLOps Model Inference Server
After=network.target

[Service]
User=$USER
WorkingDirectory=/home/$USER
Environment="GCS_BUCKET=mlops-lab-bucket-nhanphan-2026"
Environment="GOOGLE_APPLICATION_CREDENTIALS=/home/$USER/sa-key.json"
ExecStart=/usr/bin/python3 /home/$USER/src/serve.py
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable mlops-serve
