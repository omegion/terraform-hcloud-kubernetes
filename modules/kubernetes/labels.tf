resource "null_resource" "labels" {
  depends_on = [null_resource.kubeadm_join]

  connection {
    host  = var.master_nodes[0].ipv4_address
    user  = "root"
    agent = true
  }

  provisioner "remote-exec" {
    inline = [
      data.template_file.labels.rendered
    ]
  }
}

data "template_file" "labels" {
  template = file("${path.module}/scripts/labels.sh")

  vars = {
    worker_node_names = join(",", var.worker_nodes.*.name)
  }
}
