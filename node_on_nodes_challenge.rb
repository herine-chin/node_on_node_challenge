# Assumption: what is shared? How many times this node shows up as a child under other nodes.
# Assmption: total number of unique nodes includes the given node
# Assumption: we don't traverse already traversed parts of the tree (endless?)
# Assumption: tie breaker for most shared is the first one

# Misc: recursion assessing children node, bubble up results

# What is the total number of unique nodes?
# Which node ID is shared the most among all other nodes?

# { 
#   unique_node_count: ,
#   most_shared_node_id:
# }

# 1. solve for the simplest case
# 2. set up data
# 3. set up test
# 4. repeat with more scenarios

def analyze_nodes(tree_data, node_ids)
  given_node = node_ids[0]
  unique_node_count = 0
  child_node_appearances = {}

  tree_data.each do |node|
    unique_node_count += 1

    node[:child_node_ids].each do |child_id|
      unique_node_count += 1

      if child_node_appearances[child_id].nil?
        child_node_appearances[child_id] = 1
      else
        child_node_appearances[child_id] += 1
      end
    end

    break if given_node == node[:id]
  end

  [unique_node_count, find_most_shared(child_node_appearances)]
end

# greedy
def find_most_shared(counts)
  most_shared_id = nil
  highest_count = 0

  counts.each do |id, count|
    if count > highest_count
      most_shared_id = id
    end
  end

  most_shared_id
end

# ---------------------------------------------

def assert(tree_data, scenario, node_ids, expected)
  print(scenario)
  result = analyze_nodes(tree_data, node_ids)
  puts(result == expected)
  print result
  puts
end

test_data1 = [{id: 1, child_node_ids: []}]
scenario1 = "given node has no children nodes: "
assert(test_data1, scenario1, 1, [1, nil])

test_data2 = [{id: 1, child_node_ids: [2]}, {id: 2, child_node_ids: []}]
scenario2 = "given node has on child node: "
assert(test_data2, scenario2, 1, [2, 2])

test_data3 = [{id: 1, child_node_ids: [2]}, {id: 2, child_node_ids: []}, {id: 3, child_node_ids: []}]
scenario3 = "given node has multiple child nodes: "
assert(test_data3, scenario3, 1, [3, 2])

# given node has grandchildren nodes

# given node id is not root of tree

# given node has shared children with another node

# given multiple nodes

# given node is a descendent node

# given id isn't found
