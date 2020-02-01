resource "google_compute_instance" "default" {
  project      = "<PROJECT_ID>"
  name         = "terraform"
  machine_type = "n1-standard-1"
  zone         = "ZONE"

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


# Run the commands below. Set your PROJECT_ID, and ZONE
# terraform init
# terraform plan
# terraform apply
