#!/bin/bash

export PROJECT_ID=<PROJECT_ID>
export ZONE=us-central1-a
export INSTANCE_TYPE=n1-standard-1

cat > instance.tf << _EOF

resource "google_compute_instance" "default" {
  project      = "$PROJECT_ID"
  name         = "terraform"
  machine_type = "$INSTANCE_TYPE"
  zone         = "$ZONE"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}
_EOF

terraform init
sleep 2
terraform plan
echo "yes" | terraform apply & pid=$!
wait $pid
echo $pid completed
