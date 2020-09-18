resource "random_string" "wallet_password" {
  length  = 16
  special = true
}

data "oci_database_autonomous_database_wallet" "ATP_database_wallet" {
  autonomous_database_id = oci_database_autonomous_database.ATPdatabase.id
  password               = random_string.wallet_password.result
  base64_encode_content  = "true"
}

resource "local_file" "ATP_database_wallet_file" {
  content_base64  = data.oci_database_autonomous_database_wallet.ATP_database_wallet.content
  filename = var.ATP_tde_wallet_zip_file
}