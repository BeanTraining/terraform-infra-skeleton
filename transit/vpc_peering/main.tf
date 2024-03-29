# Requestor's side of the connection.
resource "aws_vpc_peering_connection" "requestor" {
  peer_owner_id = data.aws_caller_identity.peer.account_id
  peer_vpc_id   = var.peer_vpc_id
  vpc_id        = var.vpc_id

  # accepter {
  #   allow_remote_vpc_dns_resolution = true
  # }

  # requester {
  #   allow_remote_vpc_dns_resolution = true
  # }

  tags = {
    Name = "VPC Peering from ${var.vpc_id} to ${var.peer_vpc_id}"
    Side = "Requestor"
  }
}

# Peer/Acceptor's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.requestor.id
  auto_accept               = true

  tags = {
    Side = "Acceptor"
  }
}

resource "aws_route" "to_peer_private" {
  for_each                  = toset(data.aws_vpc.peer_vpc.cidr_block_associations.*.cidr_block)
  route_table_id            = data.aws_route_table.private.id
  destination_cidr_block    = each.key
  vpc_peering_connection_id = aws_vpc_peering_connection.requestor.id
  # depends_on                = [aws_route_table.testing]
}

resource "aws_route" "from_peer_private" {
  for_each                  = toset(data.aws_vpc.vpc.cidr_block_associations.*.cidr_block)
  route_table_id            = data.aws_route_table.peer_private.id
  destination_cidr_block    = each.key
  vpc_peering_connection_id = aws_vpc_peering_connection.requestor.id
  provider                  = aws.peer
}


resource "aws_route" "to_peer_public" {
  for_each                  = toset(data.aws_vpc.peer_vpc.cidr_block_associations.*.cidr_block)
  route_table_id            = data.aws_route_table.public.id
  destination_cidr_block    = each.key
  vpc_peering_connection_id = aws_vpc_peering_connection.requestor.id
  # depends_on                = [aws_route_table.testing]
}

resource "aws_route" "from_peer_public" {
  for_each                  = toset(data.aws_vpc.vpc.cidr_block_associations.*.cidr_block)
  route_table_id            = data.aws_route_table.peer_public.id
  destination_cidr_block    = each.key
  vpc_peering_connection_id = aws_vpc_peering_connection.requestor.id
  provider                  = aws.peer
}