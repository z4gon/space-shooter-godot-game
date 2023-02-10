static func load_nodes(context: Node, node_paths: Array) -> Array:
	var nodes = []
	for node_path in node_paths:
		var node = context.get_node(node_path)
		if node != null:
			nodes.append(node)
	return nodes
