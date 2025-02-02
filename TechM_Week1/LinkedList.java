package Week_1;

public class LinkedList {

    private Node head;

    private static class Node {
        Node next;

        Node(int data) {
            this.next = null;
        }
    }

    public boolean hasCycle(Node head) {
        if (head == null || head.next == null) {
            return false; 
        }

        Node tortoise = head;
        Node hare = head;

        while (hare != null && hare.next != null) {
            tortoise = tortoise.next;
            hare = hare.next.next;

            if (tortoise == hare) {
                return true;
            }
        }

        return false;
    }


    public static void main(String[] args) {
  
//Linked List    	
        LinkedList list = new LinkedList();
        list.head = new Node(1);
        list.head.next = new Node(2);
        list.head.next.next = new Node(3);
        list.head.next.next.next = new Node(4);

        list.head.next.next.next.next = list.head.next; 

        if (list.hasCycle(list.head)) {
            System.out.println("The linked list has a cycle");
        } else {
            System.out.println("The linked list does not have a cycle");
        }

// Empty List        
        LinkedList emptyList = new LinkedList();
        if (emptyList.hasCycle(emptyList.head)) {
            System.out.println("The empty linked list has a cycle");
        } else {
            System.out.println("The empty linked list does not have a cycle");
        }


// Single Node List
        LinkedList singleNodeList = new LinkedList();
        singleNodeList.head = new Node(1);
        if (singleNodeList.hasCycle(singleNodeList.head)) {
            System.out.println("The single node linked list has a cycle");
        } else {
            System.out.println("The single node linked list does not have a cycle");
        }

    }
}