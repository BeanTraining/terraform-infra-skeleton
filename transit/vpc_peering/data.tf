data "aws_route_table" "private" {
  subnet_id = tolist(data.aws_subnet_ids.private)[0]
}


data "aws_subnet_ids" "private" {
  vpc_id = var.vpc_id

  tags = {
    Tier = "Private"
  }
}

data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_vpc" "peer_vpc" {
  id = var.peer_vpc_id
}

data "aws_caller_identity" "peer" {
  provider = aws.peer
}

data "aws_route_table" "peer_private" {
  subnet_id = tolist(data.aws_subnet_ids.peer_private)[0]
}

data "aws_subnet_ids" "peer_private" {
  vpc_id = var.peer_vpc_id

  tags = {
    Tier = "Private"
  }
}
