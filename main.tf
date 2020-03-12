

provider "google" {
  version = "3.5.0"

  credentials = file("terraform-test-key.json")
  project     = "terraform-test-270912"
  region      = "europe-west6"
  zone        = "europe-west6-c"
}

resource "google_compute_network" "k8s-network" {
  name = "k8s-network"
}

resource "google_compute_firewall" "k8s-firewalll" {
  name    = "k8s-firewall"
  network = google_compute_network.k8s-network.name
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "8000"]
  }

}


resource "google_compute_instance" "k8s-master" {

  machine_type = "f1-micro"
  count        = var.number_master
  name         = "k8s-master-${count.index}"
  labels = {
    function = "master"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }



  network_interface {
    network = google_compute_network.k8s-network.self_link
    access_config {
    }
  }

}

resource "google_compute_instance" "k8s-node" {

  machine_type = "f1-micro"
  count        = var.number_worker
  name         = "k8s-node-${count.index}"
  labels = {
    function = "worker"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }



  network_interface {
    network = google_compute_network.k8s-network.self_link
    access_config {
    }
  }

}
