terraform {
  cloud {
    organization = "congtung07011999"

    workspaces {
      name = "abinh"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}