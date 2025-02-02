package Week_1;

import java.util.Arrays;
import java.util.LinkedList;
import java.util.Queue;

public class BinaryTree {

    public static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode(int val) {
            this.val = val;
        }
    }

    // Serialization
    public String serialize(TreeNode root) {
        if (root == null) {
            return "null";
        }
        return root.val + "," + serialize(root.left) + "," + serialize(root.right);
    }

    // Deserialization
    public TreeNode deserialize(String data) {
        if (data == null || data.isEmpty()) {
            return null;
        }

        Queue<String> nodes = new LinkedList<>(Arrays.asList(data.split(",")));
        return buildTree(nodes);
    }

    private TreeNode buildTree(Queue<String> nodes) {
        String val = nodes.poll();
        if (val.equals("null")) {
            return null;
        }

        TreeNode node = new TreeNode(Integer.parseInt(val));
        node.left = buildTree(nodes);
        node.right = buildTree(nodes);
        return node;
    }



    public static void main(String[] args) {
        BinaryTree BS = new BinaryTree();

        TreeNode root = new TreeNode(1);
        root.left = new TreeNode(2);
        root.right = new TreeNode(3);
        root.left.left = new TreeNode(4);
        root.left.right = new TreeNode(5);

// Serialization
        String serializedTree = BS.serialize(root);
        System.out.println("Serialized Tree: " + serializedTree);

// Deserialization
        TreeNode deserializedRoot = BS.deserialize(serializedTree);

       System.out.println("Deserialized root value: "+deserializedRoot.val);
       System.out.println("Deserialized left child value: "+deserializedRoot.left.val);
       System.out.println("Deserialized right child value: "+deserializedRoot.right.val);
       System.out.println("Deserialized left child's left child value: "+deserializedRoot.left.left.val);
       System.out.println("Deserialized left child's right child value: "+deserializedRoot.left.right.val);

    }
}