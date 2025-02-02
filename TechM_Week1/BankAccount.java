package Week_1;

public class BankAccount {
	
    private double balance;
    
    public BankAccount(double initialBalance) {
        this.balance = initialBalance;
    }

    public synchronized void deposit(double amount) { 
        balance += amount;
        System.out.println(Thread.currentThread().getName() + ": Deposited Rs." + amount + "\n New balance: Rs." + balance);
      
    }

    public synchronized void withdraw(double amount) { 
        if (balance >= amount) {
            balance -= amount;
            System.out.println(Thread.currentThread().getName() + ": Withdrew Rs." + amount + "\n New balance: Rs." + balance);
        } else {
            System.out.println(Thread.currentThread().getName() + ": Insufficient funds to withdraw Rs." + amount + "\n Current balance: Rs." + balance);
        }
    }

    public synchronized double getBalance() {
        return balance;
    }

    public static void main(String[] args) {
        BankAccount account = new BankAccount(1000);

        Thread t1 = new Thread(() -> {
            account.deposit(500);
            account.withdraw(200);
        }, "Thread 1");

        Thread t2 = new Thread(() -> {
            account.deposit(300);
            account.withdraw(100);
        }, "Thread 2");

        t1.start();
        t2.start();

        try {
            t1.join();
            t2.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        System.out.println("Final balance: Rs. " + account.getBalance());
    }
}