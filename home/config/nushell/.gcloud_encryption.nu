def gcp_key_encrypt [environment: string, file_to_encrypt: string, encryption_destination: string] {
      gcloud kms encrypt --project $"fxei-data-platform-($environment)" --location europe-west3 --keyring default-europe-west3 --key terraform-secrets --plaintext-file $file_to_encrypt --ciphertext-file=- | base64 | save $encryption_destination
}

def gcp_key_decrypt [environment: string, file_to_decrypt: string, decryption_destination: string] {
      cat $file_to_decrypt | base64 --decode | gcloud kms decrypt --project $"fxei-data-platform-($environment)" --location europe-west3 --keyring default-europe-west3 --key terraform-secrets --ciphertext-file=- --plaintext-file $decryption_destination
}
