package Week_1;

import java.util.Comparator;
import java.util.PriorityQueue;
import java.util.HashMap;
import java.util.Map;

class Task {
    String id;
    String description;
    int priority;

    public Task(String id, String description, int priority) {
        this.id = id;
        this.description = description;
        this.priority = priority;
    }

    @Override
    public String toString() {
        return "Task{" +
                "id= " + id +
                ", description= " + description + 
                ", priority= " + priority +
                "}";
    }
}

public class TaskManager {

    PriorityQueue<Task> taskQueue;
    Map<String, Task> taskMap;

    TaskManager() {
        taskQueue = new PriorityQueue<>(Comparator.comparingInt(task -> -task.priority));
        taskMap = new HashMap<>();
    }

    public void addTask(String id, String description, int priority) {
        Task task = new Task(id, description, priority);
        taskQueue.offer(task);
        taskMap.put(id, task);
    }

    public void removeTask(String id) {
        Task taskToRemove = taskMap.get(id);
        if (taskToRemove != null) {
            taskQueue.remove(taskToRemove);
            taskMap.remove(id);
        }
    }

    public Task getHighestPriorityTask() {
        return taskQueue.peek();
    }


    public static void main(String[] args) {
        TaskManager manager = new TaskManager();

        manager.addTask("1", "Shopping", 1);
        manager.addTask("2", "Work Project", 3);
        manager.addTask("3", "Doctor Appointment", 4);
        manager.addTask("4", "Pay Bills", 2);


        System.out.println("Highest Priority Task: " + manager.getHighestPriorityTask()+"\n");

        manager.removeTask("3");
        System.out.println("Highest Priority Task after removing task 3: " + manager.getHighestPriorityTask()+"\n");

        System.out.println("All tasks currently present in the queue with respect to their priority: ");
        while (!manager.taskQueue.isEmpty()) {
             System.out.println(manager.taskQueue.poll());
        }

    }
}